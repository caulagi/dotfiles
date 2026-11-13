{
  office-laptop = {
    system = "aarch64-darwin";
    isDarwin = true;
    hostname = "pradipcaulagi-macbook";
    users = ["pradipcaulagi" "pcaulagi" "nixuser2"];
    git.work = {
      dir = "~/playground/src/";
      email = "pradip@playgroundtech.io";
    };
  };

  ica-laptop = {
    system = "aarch64-darwin";
    isDarwin = true;
    # Nix on this Mac was installed with the Determinate installer, which runs
    # its own daemon; nix-darwin must not manage Nix here.
    determinateNix = true;
    hostname = "SEM7NVTFYKW";
    users = ["icw099"];
    git = {
      githubUser = "caulagi";
      work = {
        dir = "~/ica/src/";
        email = "pradip.caulagi@ica.se";
        signingKey = "D7FE97DE74A0B70A";
      };
    };
  };

  home-laptop = {
    system = "x86_64-linux";
    isDarwin = false;
    hostname = "home-laptop";
    users = ["pcaulagi"];
  };

  wsl = {
    system = "x86_64-linux";
    isDarwin = false;
    isWsl = true;
    hostname = "SEC56565";
    users = ["icw099"];
    git = {
      email = "pradip.caulagi@ica.se";
      signingKey = "E2B5C519C7475958";
    };
  };
}
