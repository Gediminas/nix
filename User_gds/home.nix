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
    nixfmt
    xdg-utils

    # Hardware Tools
    ethtool
    hwinfo
    lshw
    lsof
    sysstat
    usbutils

    # Network Tools
    inetutils  #telnet
    iperf
    mtr
    openssl
    openvpn
    teleport

    # Tools
    atool
    unzip

    # Development
    gdb
    lldb
    valgrind
    vagrant
    cloc         # Code line counter
    marksman     # LSP markdown
    nil          # LSP nix

    # TUI Apps
    htop
    gitui
    lazygit

    # Sway
    swappy
    
    # GUI Apps
    brave
    bitwarden
    caprine-bin
    gimp
    simplenote
    standardnotes
    #skypeforlinux
    slack
    spotify
    viber
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
