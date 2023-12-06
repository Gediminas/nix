# ## MacBookPro Retina WORKAROUND
# stty rows 50 cols 160
#
# ## NETWORK
# nmcli dev wifi rescan
# nmcli dev wifi list
# sudo nmcli dev wifi connect <ssid> --ask
#
# ## SpaceFN Build
# git clone https://github.com/Gediminas/spacefn-evdev
# $ nix-shell -p gcc pkgconfig libevdev
# make
#
# ## Fix after copy
# sudo chown -R gds:users ~/
# sudo find ~/.ssh/ -type d -exec chmod 700 {} \;
# sudo find ~/.ssh/ -type f -exec chmod 600 {} \;
#
# ## Vagrant plugins
# vagrant plugin install vagrant-reload
#
# # Vim LSP install
# nix-shell -p gcc gnumake lua luarocks rust-analyzer clang python3 pyright nodejs --run nvim
#
# # Flatpak
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpak install viber
#
# brave://flags/ # enable-webrtc-pipewire-capturer

# TODO
# echo  'ACTION=="add",SUBSYSTEM=="input",ATTR{name}=="TPPS/2 IBM TrackPoint",ATTR{device/drift_time}="25"'  > /etc/udev/rules.d/10-trackpoint.rules

{ pkgs, ... }: {
  system.stateVersion = "23.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };
  # boot.kernelPackages = pkgs.linuxPackages_5_15;
  # boot.kernelPackages = pkgs.linuxPackages_6_1;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  security.polkit.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;
  #security.pam.enableSSHAgentAuth = true;

  nix.settings.experimental-features = "nix-command flakes";

  networking.hostName = "T2215"; # Define your hostname.
  networking.networkmanager.enable = true;
  # or
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.wireless.userControlled.enable = true;

  time.timeZone = "Europe/Vilnius";
  i18n.defaultLocale = "en_US.UTF-8";

  sound.enable = true;
  hardware = {
    bluetooth.enable = true;
    bluetooth.settings = {
      General = {
        ControllerMode = "bredr";
        #Enable = "Source,Sink,Media,Socket";
      };
      Policy = { AutoEnable = "true"; };
    };
    pulseaudio.enable = false;
  };

  #https://github.com/intel/icamerasrc/tree/icamerasrc_slim_api
  # hardware.ipu6.enable = true;
  # hardware.ipu6.platform = "ipu6ep";
  ### hardware.ipu6.platform = "ipu6";

  # Flatpak desktop extensions
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
  };

  services = {
    # Configure keymap in X11
    xserver = {
      layout = "us";
      xkbVariant = "";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    flatpak.enable = true;
    blueman.enable = true;
    tlp.enable = true;

    fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-vfs0090;# (If the vfs0090 Driver does not work, use the following driver)
        #driver = pkgs.libfprint-2-tod1-goodix; (On my device it only worked with this driver)
      };
    };
  };
  security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;
  security.pam.services.xlock.fprintAuth = true;
  # TEMP
  services.uvcvideo.dynctrl.enable = true;
  services.uvcvideo.dynctrl.packages = [ pkgs.tiscamera ];

  services.transmission.enable = true;

  # services.getty.autologinUser = "gds";
  # systemd.services."autovt@tty1".description = "Autologin at the TTY1";
  # systemd.services."autovt@tty1".after = [ "systemd-logind.service" ];  # without it user session not started and xorg can't be run from this tty
  # systemd.services."autovt@tty1".wantedBy = [ "multi-user.target" ];
  # systemd.services."autovt@tty1".serviceConfig =
  #   { ExecStart = [
  #       ""  # override upstream default with an empty ExecStart
  #       "@${pkgs.utillinux}/sbin/agetty agetty --login-program ${pkgs.shadow}/bin/login --autologin gds --noclear %I $TERM"
  #     ];
  #     Restart = "always";
  #     Type = "idle";
  #   };

  # END TEMP

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  # virtualisation.libvirtd.enable = true;
  # virtualisation.virtualbox.host.package = pkgs.unstable.virtualbox;
  # with these fails vagrant up
  # virtualisation.virtualbox.host.enableExtensionPack = true; #USB support
  users.extraGroups.vboxusers.members = [ "gds" ];

  #environment.etc."vbox/networks.conf".text = "* 192.168.0.0/16";
  environment.etc."vbox/networks.conf".text = "* 0.0.0.0/0 ";

  users.users.gds = {
    isNormalUser = true;
    description = "gds";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "disk"
      "docker"
      "vboxusers"
      "libvirtd"
      "qemu-libvirtd"
      "wireshark"
    ];
    initialPassword = "password";
    # packages = with pkgs; [ ];
    # shell = pkgs.zsh;
    shell = pkgs.fish;
  };

  programs = {
    # sway.enable = true;
    # zsh.enable = true;

    fish = {
      enable = true;
      loginShellInit = ''
        if test (id --user $USER) -ge 1000 && test (tty) = "/dev/tty1"
          exec sway
        end
      '';
    };

    # starship.enable = true;
    nm-applet.indicator = true;
    git = {
      enable = true;
      package = pkgs.gitFull;
    };
    wireshark.enable = true;
  };

  programs.sway = {
    enable = true;
    # wrapperFeatures.gtk = true; # so that gtk works properly
    # extraSessionCommands = "export MOZ_ENABLE_WAYLAND=1";
    extraPackages = with pkgs; [
      alacritty
      dmenu
      grim
      slurp
      swappy
      swayidle
      swayimg
      swaylock
      waybar
      wl-clipboard
      wofi
      xwayland
    ];
  };

  nixpkgs.config.allowUnfree = true;
  documentation.dev.enable = true;

  environment.variables.EDITOR = "hx";

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  #http://localhost:631/
  services.printing.enable = true;
  services.system-config-printer.enable = true;
  programs.system-config-printer.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #https://github.com/intel/icamerasrc/tree/icamerasrc_slim_api
    # gst_all_1.icamerasrc-ipu6ep
    # linuxKernel.packages.linux_5_15.rtw89
    linuxHeaders
    man-pages
    man-pages-posix
    home-manager
    hack-font

    # keyd
    git
    curl
    wget
    cryptsetup
    git-crypt
    gnupg
    tmux
    vim
    # neovim

    fish
    # fishPlugins.hydro
    # unstable.fishPlugins.hydro
    unstable.helix

    # unstable.zellij
    # zellij
    # use compiled

    tree
    vifm
    mc
    sshfs-fuse
    file
    fzf
    jq
    fd
    ripgrep
    silver-searcher
    neofetch
    htop
    powertop
    powerstat
    killall
    inotify-tools
    # vagrant

    # bash

    #=== controls ===
    pavucontrol
    pulseaudio
    brightnessctl
    playerctl

    #=== sway ===
    # sway
    # swaylock
    # swayidle
    # waybar
    # wofi
    # dmenu
    # wl-clipboard
    # grim
    # slurp
    # alacritty
    networkmanagerapplet

    fprintd

    #for wg script
    dig
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "UbuntuMono" ]; })
    hack-font
  ];

  # Migrated to `keyd`
  # systemd.services.spacefn = {
  #   enable = true;
  #   description = "SpaceFn";
  #   unitConfig = { Type = "simple"; };
  #   serviceConfig = {
  #     ExecStart = "/bin/sh /home/gds/sub/spacefn-evdev/space";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };
  services.keyd = {
    enable = true;
    settings = {
      main = {
        leftcontrol = "layer(meta)";              # sway key
        leftmeta    = "layer(alt)";               # as in MacOS (command)
        leftalt     = "layer(control)";           # as in MacOS (command) copy/paste
        rightalt    = "layer(shift)";             # easier, no need for capslock
        sysrq       = "layer(altgr)";
        capslock    = "overload(control, esc)";
        space       = "overload(spaceFn, space)";
        semicolon   = "overload(diacritic, semicolon)";
        dot         = "overload(diacritic, dot)";

        leftshift = "oneshot(shift)";

        # meta = oneshot(meta)
        # control = oneshot(control)
      };

      spaceFn = {
        # Navigation
        "y"         = "space";
        "u"         = "home";
        "i"         = "C-left";
        "o"         = "C-right";
        "p"         = "end";
        "backspace" = "delete";

        "h"     = "left";
        "j"     = "down";
        "k"     = "up";
        "l"     = "right";
        ";"     = "enter";
        "enter" = "M-enter";

        "m" = "escape";
        "," = "backspace";
        "." = "C-backspace";

        # Sway workspaces
        "1" = "M-1";
        "2" = "M-2";
        "3" = "M-3";
        "4" = "M-4";
        "5" = "M-5";
        "6" = "M-6";
        "7" = "M-7";
        "8" = "M-8";
        "9" = "M-9";
        "0" = "M-0";
        "-" = "M-minus";
        "=" = "M-equal";
        "delete" = "M-delete";

        "tab" = "M-tab";
        "e" = "M-e";
        "r" = "M-r";
        "t" = "M-t";

        "capslock" = "M-escape";
        "a" = "M-a";
        "s" = "M-s";
        "d" = "M-d";
        "f" = "M-f";
        "g" = "M-g";

        # copy/paste
        "c" = "C-c";
        "v" = "C-v";
        "x" = "C-x";
      };

      # symbols = {
      #   "d" = "(";
      #   "f" = ")";
      #   "," = "backspace";
      # };

      diacritic = {
        "q" = "G-e";
        "w" = "G-4";     # Ė
        "e" = "G-3";     # Ę

        "a" = "G-1";     # Ą
        "s" = "G-6";     # Š
        "d" = "G-7";     # Ų
        "f" = "G-5";     # Į

        "z" = "G-equal"; # Ž
        "x" = "G-8";     # Ū
        "c" = "G-2";     # Č

        "y" = "semicolon";
        "m" = "escape";
        "," = "backspace";
        "." = "C-backspace";
      };

    };
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true; //xz - https://nixos.wiki/wiki/Polkit


  # Firewall
  networking.nftables.enable = true;
  networking.firewall.enable = true;
  networking.firewall.extraPackages = [ pkgs.conntrack-tools ];
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}
