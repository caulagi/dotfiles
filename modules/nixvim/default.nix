{ pkgs, nixvim, ... }: {
  environment.systemModules = [
    (nixvim.legacyPackages."${system}".makeNixvim {
      colorschemes.gruvbox.enable = true;
    })
  ];
  home-manager.users.pradipcaulagi = {
    programs.nixvim = {
      enable = true;
      colorschemes.gruvbox.enable = true;
    };
  };
}
