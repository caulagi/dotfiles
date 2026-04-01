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
    usersConfig = import ./modules/darwin/users.nix;
    pkgs = nixpkgs.legacyPackages.aarch64-darwin;
  in {
    formatter.aarch64-darwin = pkgs.alejandra;
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    darwinConfigurations.darwin = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
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
            users = pkgs.lib.genAttrs usersConfig.users (user: {
              imports = [
                ./modules/home-manager
                usersConfig.darwinHomeManager
              ];
            });
          };
        }
        ./modules/environment.nix
      ];
    };

    packages.aarch64-darwin.dotnet = import ./pkgs/dotnet.nix {pkgs = nixpkgs.legacyPackages.aarch64-darwin;};
    packages.x86_64-linux.dotnet = import ./pkgs/dotnet.nix {pkgs = nixpkgs.legacyPackages.x86_64-linux;};

    homeConfigurations.playgroundpc = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      modules = [
        ./modules/home-manager
        {
          home.username = "playgroundpc";
          home.homeDirectory = "/home/playgroundpc";
        }
      ];
    };
  };
}
