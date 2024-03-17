{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
  ];
  home-manager.users.pradipcaulagi.programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      color = "always";
    };
  };
}
