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

    inxi
    glxinfo
    xorg.xdpyinfo
    lm_sensors

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
    swayimg
    
    # GUI Apps
    brave
    bitwarden
    gimp
    imagemagick
    simplenote
    standardnotes
    #skypeforlinux
    slack
    spotify
    wireshark
    
    ############################
    # Experimental
    kitty
    viu
    xfce.ristretto
    poppler_utils
    zathura
    mupdf
    masterpdfeditor
    adobe-reader
    ffmpeg_5-full
    mp3info
    sox
    sxiv
    gpicview
    shotwell
    xfce.thunar
    ntfs3g

    # Flatpak
    #caprine-bin
    #viber
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "adobe-reader-9.5.5"
  ];


  home.file = {
    ".tmux.conf".source = ./tmux/.tmux.conf;
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
