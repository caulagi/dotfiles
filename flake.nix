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
    mkDarwinConfig = username:
      darwin.lib.darwinSystem {
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
  in {
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    darwinConfigurations.pradipcaulagi = mkDarwinConfig "pradipcaulagi";
    darwinConfigurations.otheruser = mkDarwinConfig "pcaulagi";
  };
}
