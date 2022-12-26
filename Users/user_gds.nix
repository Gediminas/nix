{ config, pkgs, ... }:

{
  home.stateVersion = "22.11";

  home.username = "gds";
  home.homeDirectory = "/home/gds";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    openvpn
    nixfmt

    # TUI Apps
    htop
    gitui
    lazygit

    # GUI Apps
    brave
    slack
    bitwarden
  ];

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
