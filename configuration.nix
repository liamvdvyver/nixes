# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pavillion"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # pipewire #
  services.pipewire.enable = false;
  services.pulseaudio.enable = true;
  services.pulseaudio.support32Bit = true;

  # Enable X11 #
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;

  # Enable ZSH #
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.variables = rec {
    ZDOTDIR = "$HOME/.config/zsh"; # To source configs
  };

  # Use unpatched bins #
  # programs.nix-ld.enable = true;

  # Use direnv #
  programs.direnv.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lvdv = {
    isNormalUser = true;
    description = "Liam van der Vyver";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
      tmux
      ranger
      direnv
      qutebrowser
      kitty
      yadm
      zoxide
      fzf
      fd
      bat
      eza
      ripgrep
      i3
      rofi
      networkmanager_dmenu
      rofi-bluetooth
      rofi-pulse-select
      sxhkd
      unzip
      btop
      pavucontrol
      ueberzugpp
      nsxiv
      zathura
      zotero
      sioyek
      syncthing
      arandr
      autorandr
      pass
      gnupg
      pinentry-all
      brave
      calibre
      killall
      # i3lock

      xfce.xfce4-power-manager
      acpi
      # acpilight
      # xbacklight

      # Tmux bar
      pulsemixer
      upower

      # scripts
      xclip
      xdotool

      # Mason
      nodejs
      lua
      luarocks
      gcc
      python3

      # cmake
      # clang
      emacs

      obs-studio
      ncmpcpp
      mpv
      ncspot
      librespot

    ];
  };

  fonts.packages = with pkgs; [
      nerd-fonts.hack
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
  ];
   

  programs.zsh = {
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.light.enable = true;
  programs.i3lock.enable = true;

  services.syncthing = {
    enable = true;
    user = "lvdv";
    openDefaultPorts = true;
    dataDir = "/home/lvdv/Documents";
    configDir = "/home/lvdv/.config/syncthing";
    settings = {
      devices = {
    };
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.upower.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "25.11"; # Did you read the comment?

}
