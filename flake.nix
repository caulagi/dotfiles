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
    hosts = import ./hosts.nix;
    usersConfig = import ./modules/darwin/users.nix;

    mkDarwinHost = name: host:
      darwin.lib.darwinSystem {
        system = host.system;
        pkgs = import nixpkgs {
          system = host.system;
          config.allowUnfree = true;
        };
        specialArgs = {inherit host;};
        modules = [
          ./modules/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users = nixpkgs.legacyPackages.${host.system}.lib.genAttrs host.users (user: {
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

    mkHomeHost = name: host:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = host.system;
          config.allowUnfree = true;
        };
        modules =
          map (user: {
            home.username = user;
            home.homeDirectory = "/home/${user}";
          })
          host.users
          ++ [
            ./modules/home-manager
          ];
      };

    darwinHosts = nixpkgs.lib.filterAttrs (_: h: h.isDarwin) hosts;
    homeHosts = nixpkgs.lib.filterAttrs (_: h: !h.isDarwin) hosts;
  in {
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    darwinConfigurations = nixpkgs.lib.mapAttrs mkDarwinHost darwinHosts;

    homeConfigurations = nixpkgs.lib.mapAttrs mkHomeHost homeHosts;

    packages.aarch64-darwin.dotnet = import ./pkgs/dotnet.nix {pkgs = nixpkgs.legacyPackages.aarch64-darwin;};
    packages.x86_64-linux.dotnet = import ./pkgs/dotnet.nix {pkgs = nixpkgs.legacyPackages.x86_64-linux;};
  };
}
