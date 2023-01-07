# INSTALL
#
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
# ## Install vagrant plugins
# vagrant plugin install vagrant-reload

{ config, pkgs, lib, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  security.polkit.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;

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
    getty.autologinUser = "gds";
    flatpak.enable = true;
    blueman.enable = true;
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  #Virtualbox
  virtualisation.virtualbox.host.enable = true;
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
    packages = with pkgs; [ ];
    # shell = pkgs.zsh;
    shell = pkgs.fish;
  };

  programs = {
    sway.enable = true;
    # zsh.enable = true;
    fish.enable = true;
    # starship.enable = true;
    nm-applet.indicator = true;
    git = {
      enable = true;
      package = pkgs.gitFull;
    };
    wireshark.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  environment.variables.EDITOR = "hx";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    hack-font
    git
    curl
    wget
    cryptsetup
    git-crypt
    gnupg
    tmux
    vim
    neovim
    unstable.helix
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

    # bash

    #=== controls ===
    pavucontrol
    pulseaudio
    brightnessctl
    playerctl

    #=== sway ===
    sway
    swaylock
    swayidle
    waybar
    wofi
    dmenu
    wl-clipboard
    grim
    slurp
    alacritty
    networkmanagerapplet
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "UbuntuMono" ]; })
    hack-font
  ];

  systemd.services.spacefn = {
    enable = true;
    description = "SpaceFn";
    unitConfig = { Type = "simple"; };
    serviceConfig = {
      ExecStart = "/bin/sh /home/gds/sub/spacefn-evdev/space";
    };
    wantedBy = [ "multi-user.target" ];
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "22.11";

}
