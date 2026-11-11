{
  office-laptop = {
    system = "aarch64-darwin";
    isDarwin = true;
    hostname = "pradipcaulagi-macbook";
    users = ["pradipcaulagi" "pcaulagi" "nixuser2"];
  };

  ica-laptop = {
    system = "aarch64-darwin";
    isDarwin = true;
    hostname = "SEM7NVTFYKW";
    users = ["icw099"];
    git = {
      email = "pradip.caulagi@ica.se";
      githubUser = "pcaulagi-ica";
      # signingKey = "...";  # set once the ICA GPG key exists on this Mac
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
