{
  config,
  pkgs,
  ...
}: {

  # here go the darwin preferences and config items
  programs.bash.enable = true;
  environment = {
    variables = {
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_STATE_HOME  = "$HOME/.local/state";

      EDITOR = "nvim";
    };

    systemPackages = [ pkgs.coreutils ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.keyboard.enableKeyMapping = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  users.users.pradipcaulagi.home = "/Users/pradipcaulagi";

  networking = {
    hostName = "pcaulagi-cdon-macbook";
  };


  fonts.fontDir.enable = true;
  fonts.fonts = [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
  services.nix-daemon.enable = true;
  system = {
    defaults = {
      finder.AppleShowAllExtensions = true;
      finder._FXShowPosixPathInTitle = true;
      # don't show desktop icons
      finder.CreateDesktop = false;
      # default to list view
      finder.FXPreferredViewStyle = "Nlsv";
      dock.autohide = true;
      dock.autohide-delay = 0.01;
      dock.autohide-time-modifier = 0.01;
      dock.show-recents = false;

      CustomSystemPreferences = {
        NSGlobalDomain = {
          NSWindowShouldDragOnGesture = true;
        };
      };

      NSGlobalDomain = {
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.0;

        # full keyboard control
        AppleKeyboardUIMode = 3;

        # allow key repeat
        ApplePressAndHoldEnabled = false;
        # delay before repeating keystrokes
        InitialKeyRepeat = 15; # normal minimum is 15 (225 ms)
        # delay between repeated keystrokes upon holding a key
        KeyRepeat = 2; # normal minimum is 2 (30 ms)
        AppleShowAllExtensions = true;
        # AppleShowScrollBars = "Automatic";

        # Reduce window animations
        NSWindowResizeTime = 0.1;

        # window open/close animation
        NSAutomaticWindowAnimationsEnabled = false;
      };
    };
    # backwards compat; don't change
    stateVersion = 4;

    activationScripts.postActivation.text = ''sudo chsh -s ${pkgs.bashInteractive}/bin/bash''; # Since it's not possible to declare default shell, run this command after build

  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    # use home brew to install packages for spotlight to work
    casks = [ "wezterm" ];
  };
}
