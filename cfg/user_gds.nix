{ config, pkgs, ... }:

{
  home.username = "gds";
  home.homeDirectory = "/home/gds";

  home.packages = with pkgs; [
    htop
      # VPN
      openvpn

      # DEV
      gitui
      lazygit
      #gcc
      #clang
      #cmake
      gnumake
      #pkg-config
      libevdev
      nixfmt

      # GUI Apps
      brave
  ];

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;


  #home.file = {
    #".config/alacritty/alacritty.yaml" = ''
      #env:
        #TERM: xterm-256color
      #font:
        #normal:
          #family: monospace
      #colors:
        #primary:
           #background: '#151530'
        #normal:
           #green:   '#00bb00'
      #selection:
        #save_to_clipboard: true
    #'';
  #}
}