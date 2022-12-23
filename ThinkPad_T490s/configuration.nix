{ config, pkgs, lib, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  security.polkit.enable = true;
  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;

  nix.settings.experimental-features = "nix-command flakes";

  #nix.nixPath = [ "nixpkgs=$(nixpkgs)" ];

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
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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

  users.users.gds = {
    isNormalUser = true;
    description = "gds";
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "password";
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  programs.sway.enable = true;
  programs.zsh.enable = true;
  programs.git.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.variables.EDITOR = "hx";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #home-manager
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
    fzf
    ripgrep
    silver-searcher
    neofetch
    htop
    powertop
    powerstat
    inotify-tools

    pavucontrol

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
