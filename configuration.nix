# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  security.polkit.enable = true;
  security.sudo.wheelNeedsPassword = false;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  # or
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.wireless.userControlled.enable = true;

  time.timeZone = "Europe/Vilnius";
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    # Configure keymap in X11
    xserver = {
      layout = "us";
      xkbVariant = "";
    };
    getty.autologinUser = "gds";
    mbpfan.enable = true;
    mbpfan.settings.general.min_fan1_speed = 1250;
  };
  

  users.users.gds = {
    isNormalUser = true;
    description = "gds";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;



  };

  programs.sway.enable = true;
  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    hack-font
    #hackgen-font
    #hackgen-nf-font
    git
    vim
    neovim
    vifm
    mc
    tree
    wget
    curl
    tmux
    gcc
    clang
    cmake
    gnumake
    sway
    swaylock
    swayidle
    waybar
    wofi
    wl-clipboard  # wl-copy and wl-paste for copy/paste from stdin / stdout
    grim          # screenshot functionality
    slurp         # screenshot functionality
    dmenu
    #bemenu        # wayland clone of dmenu
    mako          # notification system developed by swaywm maintainer
    brave
    alacritty     # gpu accelerated terminal
    pkg-config
    libevdev
    networkmanagerapplet
    fzf
    ripgrep
    silver-searcher
    neofetch
    sshfs-fuse
    openvpn
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "UbuntuMono" ]; })
    hack-font
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true; //xz - https://nixos.wiki/wiki/Polkit

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
