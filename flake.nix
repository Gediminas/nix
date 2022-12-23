{
  description = "NixOS System Config";

  inputs = {

    # NixOS
    nixpkgs.url          = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home-Manager
    #url = "github:nix-community/home-manager";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    #flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      system = "x86_64-linux";
      lib    = nixpkgs.lib;
      pkgs_imp = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      homeManagerConfigurations.gds = home-manager.lib.homeManagerConfiguration {
        #pkgs = nixpkgs.legacyPackages.${system};
        pkgs = pkgs_imp;
        modules = [

          # Home-manager user config
          ./cfg/user_gds.nix 

          {
            home = {
              username = "gds";
              homeDirectory = "/home/gds";
              stateVersion = "22.11";
            };
          }
        ];
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [

          # System config
          ./cfg/configuration.nix

          # Scanned Hardware
          ./cfg/hardware-configuration.nix

          # Hardware quirks
          # https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
          # nixos-hardware.nixosModules.lenovo-thinkpad-t490
          # nixos-hardware.nixosModules.lenovo-thinkpad-x1
          # nixos-hardware.nixosModules.lenovo-thinkpad-x1-10th-gen
          nixos-hardware.nixosModules.apple-macbook-pro-14-1
        ];
      };
    };
}
