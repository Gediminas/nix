{ config, pkgs, ... }:

{
  home.stateVersion = "23.11";

  home.username = "gds";
  home.homeDirectory = "/home/gds";

  home.file = {
    # ".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/tmux/.tmux.conf";
    # ".tmux/themes".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/tmux/themes";
    # ".tmux/post_save.sh".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/tmux/post_save.sh";
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/User_gds/tmux";

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
    zsh
    # fish
    # fishPlugins.tide
    # fishPlugins.hydro
    nixfmt
    direnv
    xdg-utils
    vagrant
    # virtualbox
    minikube
    kubectl

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
    # nnn
    (nnn.override { withNerdIcons = true; })
    ranger
    w3m #png/photo
    ncdu  #cleanup storage

    felix-fm chafa zoxide bat


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
    teleport_11
    wireguard-tools
    ansible
    nmap
    netcat
    hping

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
    meld
    valgrind
    cloc # Code line counter

    # LSP
    nodejs                            # only for LSP needed
    ruby                              # only for LSP needed
    lua-language-server               # LSP: lua
    rust-analyzer                     # LSP: rust 
    gopls                             # LSP: go
    golangci-lint-langserver          # LSP: go cli
    # go-tools delve gdlv             # LSP: go tools (`gdlv` for GUI)
    clang-tools                       # LSP: c/c++
    nodePackages.bash-language-server # LSP: bash
    marksman                          # LSP: markdown
    nil                               # LSP: nix
    taplo                             # LSP: toml
    # nodePackages.yaml-language-server # LSP: yaml1
    ansible-language-server           # LSP: yaml2
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
    # tor-browser-bundle-bin
    # transmission
    # transmission-gtk

    dropbox
    # drive
    # resilio-sync
    rclone

    bitwarden
    gimp
    imagemagick
    nb
    # simplenote
    standardnotes
    #skypeforlinux
    slack
    spotify
    vscode
    wireshark
    # remmina #RDC

    ############################
    # Experimental
    # albert
    kitty
    # wezterm
    foot
    broot
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
    # xfce.thunar #service
    ntfs3g
    nfs-utils
    libreoffice-qt

    # transmission
    xfce.xfce4-taskmanager
    anki-bin
    flameshot

    obsidian
    # discord
    # nextcloud-client
    synology-drive-client

    # Flatpak
    #caprine-bin
    viber
    # joplin-desktop => Joplin
    # joplin         => not

    # unfree
    # ciscoPacketTracer8

    # experimental
    # kanshi

    pcmanfm
    lf
    krusader
    krename

    zim
    cherrytree
  ];

  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.dunst.enable = false;

  nixpkgs.config.permittedInsecurePackages = [
    "adobe-reader-9.5.5"
    "teleport-11.3.27"
    "openssl-1.1.1w" #for viber
    "electron-25.9.0" #obsidian
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
