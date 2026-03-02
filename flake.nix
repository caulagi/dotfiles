{
  description = "my minimal flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    darwin,
    ...
  }: let
    username = let
      sudoUser = builtins.getEnv "SUDO_USER";
      currentUser = builtins.getEnv "USER";
    in
      if sudoUser != ""
      then sudoUser
      else currentUser;
  in {
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    darwinConfigurations.${username} = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {inherit username;};
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
      modules = [
        ./modules/darwin
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username}.imports = [./modules/home-manager];
          };
        }
        ./modules/environment.nix
      ];
    };
  };
}
