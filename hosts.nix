{
  office-laptop = {
    system = "aarch64-darwin";
    isDarwin = true;
    hostname = "pradipcaulagi-macbook";
    users = ["pradipcaulagi" "pcaulagi" "nixuser2"];
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
  };
}
