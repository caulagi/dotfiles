{
  users = ["pradipcaulagi" "pcaulagi"];

  darwinHomeManager = {...}: {
    targets.darwin.defaults = {
      "com.apple.finder" = {
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = true;
        CreateDesktop = false;
        FXPreferredViewStyle = "Nlsv";
      };

      "com.apple.dock" = {
        autohide = true;
        autohide-delay = 0.01;
        autohide-time-modifier = 0.01;
        show-recents = false;
      };

      NSGlobalDomain = {
        "com.apple.sound.beep.feedback" = 0;
        "com.apple.sound.beep.volume" = 0.0;
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        AppleShowAllExtensions = true;
        NSWindowResizeTime = 0.1;
        NSAutomaticWindowAnimationsEnabled = false;
      };
    };
  };
}
