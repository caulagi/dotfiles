{
  description = "my minimal flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Pinned to a commit that ships terraform 1.13.5
    nixpkgs-terraform.url = "github:nixos/nixpkgs/32104fd4f3652b813a8c528dbef33452d3394c45";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs @ {
    nixpkgs,
    nixpkgs-terraform,
    home-manager,
    darwin,
    ...
  }: let
    hosts = import ./hosts.nix;

    # Always provide terraform 1.13 from the pinned nixpkgs
    terraformOverlay = final: prev: {
      terraform =
        (import nixpkgs-terraform {
          inherit (prev.stdenv.hostPlatform) system;
          config.allowUnfree = true;
        }).terraform;
    };

    mkPkgs = system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [terraformOverlay];
      };

    mkDarwinHost = name: host:
      darwin.lib.darwinSystem {
        system = host.system;
        pkgs = mkPkgs host.system;
        specialArgs = {inherit host;};
        modules = [
          ./modules/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit host;};
              users = nixpkgs.legacyPackages.${host.system}.lib.genAttrs host.users (user: {
                imports = [
                  ./modules/home-manager
                  ./modules/darwin/users.nix
                ];
              });
            };
          }
          ./modules/environment.nix
        ];
      };

    mkHomeHost = name: host:
      home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs host.system;
        extraSpecialArgs = {inherit host;};
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
