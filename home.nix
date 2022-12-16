{ config, pkgs, ... }:

{
  home.username = "gds";
  home.homeDirectory = "/home/gds";

  home.packages = with pkgs; [
    htop
      # VPN
      openvpn

      # DEV
      #gcc
      #clang
      #cmake
      #gnumake
      #pkg-config
      #libevdev
      #nixfmt

      # GUI Apps
      brave
  ];

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;
}
