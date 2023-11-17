{ config, pkgs, ... }:

{
  home.stateVersion = "23.05";

  home.username = "gds";
  home.homeDirectory = "/home/gds";

  home.file = {
    ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/tmux/.tmux.conf";
    ".tmux/themes".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/tmux/themes";
    ".tmux/post_save.sh".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/tmux/post_save.sh";
    ".vim/autoload".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/vim/autoload";
    ".vim/colors".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/vim/colors";
    ".vim/vimrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/vim/vimrc";
    ".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/alacritty";
    ".config/dunst".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/dunst";
    ".config/helix".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/helix";
    ".config/fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/fish/config.fish";
    ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/kitty";
    ".config/mc/ini".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/mc/ini";
    # ".config/nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/nvim/init.lua";
    ".config/sway".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/sway";
    ".config/vifm/colors".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/vifm/colors";
    ".config/vifm/vifmrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/vifm/vifmrc";
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/waybar";
    ".config/wofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/wofi";
  };

  home.packages = with pkgs; [
    fish
    fishPlugins.tide
    nixfmt
    direnv
    xdg-utils
    vagrant
    # virtualbox

    # Desktop env
    # mako # notifications (annoying)
    dunst # notifications (customizable; invisible)

    # Hardware Tools
    ethtool
    hwinfo
    lshw
    lsof
    sysstat
    usbutils
    nnn

    inxi
    glxinfo
    xorg.xdpyinfo
    lm_sensors

    # Network Tools
    inetutils # telnet
    iperf
    mtr
    openssl
    openvpn
    tcpdump
    teleport
    wireguard-tools
    ansible
    nmap
    netcat

    # Tools
    bc
    atool
    zip
    unzip
    p7zip
    unrar
    vimv

    # Development
    gdb
    lldb
    quilt
    valgrind
    cloc # Code line counter

    # LSP
    nodejs                            # only for LSP needed
    ruby                              # only for LSP needed
    lua-language-server               # LSP: lua
    rust-analyzer                     # LSP: rust 
    gopls                             # LSP: go
    go-tools delve gdlv               # LSP: go tools (`gdlv` for GUI)
    clang-tools                       # LSP: c/c++
    nodePackages.bash-language-server # LSP: bash
    marksman                          # LSP: markdown
    nil                               # LSP: nix
    taplo                             # LSP: toml
    nodePackages.yaml-language-server # LSP: yaml
    rubyPackages.solargraph           # LSP: vagrant (ruby)

    # shell.nix:
    #  python311Packages.python-lsp-server

    # missing:
    #   docker-langserver
    #   vscode-json-language-server

    # TUI Apps
    htop
    gitui
    lazygit

    # GUI Apps
    brave
    chromium
    firefox

    dropbox
    drive

    bitwarden
    gimp
    imagemagick
    simplenote
    standardnotes
    #skypeforlinux
    slack
    spotify
    vscode
    wireshark
    # remmina #RDC

    ############################
    # Experimental
    albert
    kitty
    viu
    xfce.ristretto
    poppler_utils
    #PDF
    zathura
    mupdf
    masterpdfeditor
    adobe-reader
    calibre
    # foxitreader     # +2GB?!
    #media
    ffmpeg_5-full
    mp3info
    sox
    sxiv
    gpicview
    shotwell
    xfce.thunar
    ntfs3g
    nfs-utils
    libreoffice-qt

    transmission
    xfce.xfce4-taskmanager
    anki-bin
    flameshot

    # obsidian
    # joplin
    # joplin-desktop
    discord

    # Flatpak
    #caprine-bin
    #viber

    # unfree
    ciscoPacketTracer8
  ];

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.dunst.enable = false;

  nixpkgs.config.permittedInsecurePackages = [
    "adobe-reader-9.5.5"
    # "qtwebkit-5.212.0-alpha4" #foxitreader
  ];

  # xdg.mime.defaultApplications = {
  #   # "application/pdf" = "firefox.desktop";
  #   "image/png" = [
  #     "swayimg.desktop"
  #     "sxiv.desktop"
  #     "gimp.desktop"
  #   ];
  # };
  # xdg.mimeApps = {
  #   enable = true;
  #   associations.added = {
  #     "application/pdf" = ["org.gnome.Evince.desktop"];
  #   };
  #   defaultApplications = {
  #     "application/pdf" = ["org.gnome.Evince.desktop"];
  #   };
  # };
}
