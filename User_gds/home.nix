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

    # Tools
    teleport
    inetutils  #telnet
    iperf
    wireguard-tools
    lsof

    # Development
    gdb
    lldb
    valgrind
    vagrant
    cloc

    # TUI Apps
    htop
    gitui
    lazygit

    # Sway
    swappy
    
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
    ".tmux.conf".source = ./tmux/tmux.conf;
    ".tmux/themes".source = ./tmux/themes;
    ".vim/autoload".source = ./vim/autoload;
    ".vim/colors".source = ./vim/colors;
    ".vim/vimrc".source = ./vim/vimrc;
    ".config/alacritty".source = ./alacritty;
    ".config/helix".source = ./helix;
    ".config/fish/config.fish".source = ./fish/config.fish;
    ".config/kitty".source = ./kitty;
    ".config/mc/ini".source = ./mc/ini;
    ".config/nvim/init.lua".source = ./nvim/init.lua;
    ".config/sway".source = ./sway;
    ".config/vifm".source = ./vifm;
    ".config/waybar".source = ./waybar;
    ".config/wofi".source = ./wofi;
  };
}
