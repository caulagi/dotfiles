{
  description = "my minimal flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs:
    with inputs; let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
      };
      modules = [
        ./modules/environment.nix
      ];
    in {
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
      darwinConfigurations.pcaulagi = darwin.lib.darwinSystem {
        inherit system pkgs;

        modules =
          modules
          ++ [
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.pcaulagi.imports = [./modules/home-manager];
              };
            }
            ./modules/darwin
            {
              username = "pcaulagi";
            }
          ];
      };
      darwinConfigurations.pradipcaulagi = darwin.lib.darwinSystem {
        inherit system pkgs;
        modules =
          modules
          ++ [
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.pradipcaulagi.imports = [./modules/home-manager];
              };
            }
            ./modules/darwin
            {
              username = "pradipcaulagi";
            }
          ];
      };
    };
}
