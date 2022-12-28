{
  description = "NixOS System Config";

  inputs = {

    # NixOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home-Manager
    #url = "github:nix-community/home-manager";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware-quirks.url = "github:NixOS/nixos-hardware/master";
    #flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, nixpkgs, nixpkgs-unstable, home-manager, hardware-quirks, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs_imp = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {

      # User gds
      homeConfigurations.gds = home-manager.lib.homeManagerConfiguration {
        #pkgs = nixpkgs.legacyPackages.${system};
        pkgs = pkgs_imp;
        modules = [
          ./User_gds/home.nix
          {
            home = {
              username = "gds";
              homeDirectory = "/home/gds";
              stateVersion = "22.11";
            };
          }
        ];
      };

      # MacBookPro 14.2 with TouchBar 2017
      nixosConfigurations.mbp14 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          #FIXME: Deduplicate
          ({ ... }:
            let
              overlay-unstable = final: prev: {
                unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
              };
            in { nixpkgs.overlays = [ overlay-unstable ]; })
          #END FIXME
          ./MacBookPro_14.2_TouchBar/configuration.nix
          ./MacBookPro_14.2_TouchBar/hardware-configuration.nix
          hardware-quirks.nixosModules.apple-macbook-pro-14-1
        ];
      };

      # ThinkPad T490s
      nixosConfigurations.t490s = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          #FIXME: Deduplicate
          ({ ... }:
            let
              overlay-unstable = final: prev: {
                unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
              };
            in { nixpkgs.overlays = [ overlay-unstable ]; })
          #END FIXME
          ./ThinkPad_T490s/configuration.nix
          ./ThinkPad_T490s/hardware-configuration.nix
          hardware-quirks.nixosModules.lenovo-thinkpad-t490
        ];
      };

      # ThinkPad Carbon X1
      nixosConfigurations.x1 = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          #FIXME: Deduplicate
          ({ ... }:
            let
              overlay-unstable = final: prev: {
                unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
              };
            in { nixpkgs.overlays = [ overlay-unstable ]; })
          #END FIXME
          ./ThinkPad_X1/configuration.nix
          ./ThinkPad_X1/hardware-configuration.nix
          hardware-quirks.nixosModules.lenovo-thinkpad-x1-10th-gen
        ];
      };
    };
}
