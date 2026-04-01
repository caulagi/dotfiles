{
  config,
  pkgs,
  lib,
  host,
  ...
}: {
  # here go the darwin preferences and config items
  programs.bash.enable = true;
  environment = {
    systemPackages = [pkgs.coreutils];
    systemPath = ["/opt/homebrew/bin"];
    pathsToLink = ["/Applications"];
    shells = [pkgs.bashInteractive pkgs.fish];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.keyboard.enableKeyMapping = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  users.users = lib.genAttrs host.users (user: {
    home = "/Users/${user}";
  });

  networking = {
    hostName = host.hostname;
  };

  system = {
    defaults = {
      CustomSystemPreferences = {
        NSGlobalDomain = {
          NSWindowShouldDragOnGesture = true;
        };
      };
    };
    stateVersion = 4;

    activationScripts.postActivation.text = let
      userList = lib.concatStringsSep " " host.users;
    in ''
      for user in ${userList}; do
        if id "$user" &>/dev/null; then
          if ! dscl . -read /Users/$user UserShell | grep -q "${pkgs.bashInteractive}/bin/bash"; then
            echo "Setting shell for $user to ${pkgs.bashInteractive}/bin/bash"
            sudo chsh -s ${pkgs.bashInteractive}/bin/bash $user
          fi
        fi
      done
    '';
  };

  # Temporarily disable homebrew due to macOS 26.0.1 compatibility issues
  # homebrew = {
  #   enable = true;
  #   caskArgs.no_quarantine = true;
  #   # Temporarily disable brewfile due to macOS 26.0.1 compatibility issues
  #   onActivation = {
  #     autoUpdate = false;
  #     upgrade = false;
  #     cleanup = "none";
  #   };
  #   # use home brew to install packages for spotlight to work
  #   # casks = ["wezterm"];
  # };
}
