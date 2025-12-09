{
  pkgs,
  config,
  lib,
  ...
}: {
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/share/dotnet"
  ];

  # Install dotnet using activation script
  home.activation.installDotnet = lib.hm.dag.entryAfter ["writeBoundary"] ''
    DOTNET_DIR="${config.home.homeDirectory}/.local/share/dotnet"

    if [ ! -d "$DOTNET_DIR" ] || [ ! -f "$DOTNET_DIR/dotnet" ]; then
      echo "Installing .NET SDK..."
      mkdir -p "$DOTNET_DIR"

      # Set TERM to avoid tput warnings and set up PATH with all required utilities
      export TERM=xterm
      export PATH="${pkgs.curl}/bin:${pkgs.bash}/bin:${pkgs.gawk}/bin:${pkgs.coreutils}/bin:${pkgs.gnugrep}/bin:${pkgs.gnused}/bin:${pkgs.gnutar}/bin:${pkgs.gzip}/bin:/usr/bin:$PATH"

      # Download and run the install script
      $DRY_RUN_CMD ${pkgs.curl}/bin/curl -sSL https://dot.net/v1/dotnet-install.sh | ${pkgs.bash}/bin/bash -s -- --channel 10.0 --install-dir "$DOTNET_DIR"
    else
      echo ".NET SDK is already installed at $DOTNET_DIR"
    fi
  '';
}
