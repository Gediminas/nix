{ config, pkgs, ... }:

{
  home.stateVersion = "22.11";

  home.username = "gds";
  home.homeDirectory = "/home/gds";

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fish
    fishPlugins.tide

    openvpn
    nixfmt
    teleport

    # TUI Apps
    htop
    gitui
    lazygit

    # GUI Apps
    brave
    bitwarden
    simplenote
    standardnotes
    slack
    caprine-bin
    skypeforlinux
    spotify
    gimp
    wireshark
  ];

  home.file = {
    ".tmux/themes".source = ./tmux/themes;
    ".tmux/tmux.conf".source = ./tmux/tmux.conf;
    ".vim/autoload".source = ./vim/autoload;
    ".vim/colors".source = ./vim/colors;
    ".vim/vimrc".source = ./vim/vimrc;
    ".config/alacritty".source = ./alacritty;
    ".config/helix".source = ./helix;
    ".config/kitty".source = ./kitty;
    ".config/mc/ini".source = ./mc/ini;
    ".config/nvim/init.lua".source = ./nvim/init.lua;
    ".config/sway".source = ./sway;
    ".config/vifm".source = ./vifm;
    ".config/waybar".source = ./waybar;
    ".config/wofi".source = ./wofi;
  };

  xdg.configFile."".source = ./shell;

  # home.file = {
  #   ".config/alacritty/alacritty.yaml" = ''
  #     env:
  #       TERM: xterm-256color
  #     font:
  #       normal:
  #         family: monospace
  #     colors:
  #       primary:
  #         background: '#151530'
  #       normal:
  #         green:   '#00bb00'
  #     selection:
  #       save_to_clipboard: true
  #   '';
  # }
}
