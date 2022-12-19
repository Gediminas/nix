{
  description = "NixOS System Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    #flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let

      user_gds_cfg_path = ./cfg/user_gds.nix;
      system_cfg_path = ./cfg/configuration.nix;

      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;

    in {
      homeManagerConfigurations = {
        gds = home-manager.lib.homeManagerConfiguration {
          #pkgs = nixpkgs.legacyPackages.${system};
          pkgs = pkgs;
          modules = [
            user_gds_cfg_path 
            #./some-extra-module.nix
            {
              home = {
                username = "gds";
                homeDirectory = "/home/gds";
                stateVersion = "22.11";
              };
            }
          ];
        };
      };
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ system_cfg_path ];
        };
      };
    };
}
