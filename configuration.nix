# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  # Nix
  nix.buildCores = 6;
  nix.maxJobs = 12;


  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Drivers
    #openrazer-daemon
    #razergenie
    # linuxPackages_4_19.openrazer

    # X
    xorg.xmodmap

    # Desktop
    haskellPackages.xmonad
    haskellPackages.xmobar

    # Terminales
    screen
    alacritty
    kitty

    # Utilidades del Sistema
    wget
    rxvt_unicode
    fish
    clipmenu
    feh
    nitrogen
    openssl
    zlib
    oh-my-zsh
    git
    flatpak
    mutt
    weechat
    unar
    unrar
    unzip
    zip
    certmgr
    i3status
    stalonetray
    direnv
    nix-index
    patchelf
    usbutils
    qemu
    file

    # Editores de Texto
    vim
    emacs
    emacs-all-the-icons-fonts
    vscode
    netbeans
    android-studio

    #Navegadores
    firefox
    google-chrome
    vivaldi
    vivaldi-ffmpeg-codecs
    links

    # Aplicaciones y Bases de Datos
    libreoffice
    sqlite
    djvulibre
    imagemagick
    ffmpegthumbnailer
    gitkraken
    cargo
    postman
    mupdf
    mongodb-4_2
    mongodb-compass
    dia

    # Visores
    mupdf

    # Plasma
    plasma-vault
    libsForQt5.kdeconnect-kde
    libsForQt5.kdesu
    ark

    # Utilidad
    peco
    timg
    exa
    fd
    fzf

    #Virtualizacion
    docker
    docker-compose
    minikube
    kubernetes

    # Multimedia
    vlc
    kodi
    #steam
    teamspeak_client

    # Lenguajes de Programacion
    nodejs-16_x
    elixir
    #jdk
    #jdk11
    #jdk14
    mono
    python38Full
    robo3t
    dropbox
    dropbox-cli
    python39Full
    purescript
    spago
  ];



  nixpkgs.overlays = [(self: super:
    let
      #unstable = import <nixos-unstable> { };
      unstable = builtins.fetchTarball https://github.com/nixos/nixpkgs-channels/archive/nixos-unstable.tar.gz;
      unfreeConfig = config.nixpkgs.config // {
        allowUnfree = true;
      };
      # steam = (import unstable {}).steam;

    in {
      openrazer-daemon = (import unstable {}).openrazer-daemon;
      hardware.openrazer.enable = true;
      #programs.steam.enable = true;

      #environment.systemPackages = [
      #  steam
      #];

    }
  )];

  # Fuentes
  fonts.fonts = with pkgs; [
    hermit
    source-code-pro
    terminus_font
    powerline-fonts
    font-awesome
    cantarell-fonts
    fira
    fira-code
    nerdfonts
  ];

  # Prettify the virtual console font early on with Terminus.
  console = {
    font = "Lat2-Terminus16";
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
  };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #./razer.nix
      ./boot.nix
      ./networking.nix
      #./httpserver.nix
      #./nginx.nix
      ./regionals.nix
      ./services.nix
      ./xserver.nix
      #./gnome.nix
      ./xmonad.nix
      ./docker.nix
      #./kubernetes.nix
      #./mongodb.nix
      ./samba.nix
      # ./g13d.nix
      ./dropbox.nix
      #./tomcat.nix
    ];

  # Enable the X11 windowing system.
  environment.pathsToLink = [ "/libexec" ];

  # Pulseaudio
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;    ## If compatibility with 32-bit applications is desired.
  nixpkgs.config.pulseaudio = true;

  # services.xserver.desktopManager.wallpaper.mode = "scale";

  # Variables de Entorno
  environment.variables = {
    OH_MY_ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };


	#screenSection = ''
	#	Option         "Stereo" "0"
    	#	Option         "nvidiaXineramaInfoOrder" "DFP-1"
    	#	Option         "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    	#	Option         "SLI" "Off"
    	#	Option         "MultiGPU" "Off"
    	#	Option         "BaseMosaic" "off"
	#'';



  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.blackraider = {
    isNormalUser = true;
    extraGroups = [ "wheel" "www-data" "audio" "plugdev" "vboxusers" "libvirtd" "kvm" ]; # Enable ‘sudo’ for the user.
  };


  users.users.blacky = {
    isNormalUser = true;
    extraGroups = [ "wheel" "www-data" "audio" "plugdev" "vboxusers" "libvirtd" "kvm" ]; # Enable ‘sudo’ for the user.
  };

  #Enable VirtualBox

  virtualisation.virtualbox.host.enable = false;
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  #users.extraGroups.vboxusers.members = [ "blackraider" ];

  users.extraUsers.blackraider = {
    shell = pkgs.fish;
  };

  # Enable Steam

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        pango
        harfbuzz
      ];
    };
  };

  programs.steam.enable = true;


  programs.zsh.enable = true;
  programs.fish.enable = true;

  programs.zsh.interactiveShellInit = "export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/";
  programs.zsh.promptInit = "";

  programs.zsh.ohMyZsh = {
    enable = true;

    plugins = [ "git" "python" "man" "bower" "cabal" "colorize" "grunt" "gulp" "ng" "npm" "perl" "python" "rails" "ruby" "scala" "screen" "stack" "sudo" "yarn"  ];
    theme = "agnoster";
  };

  services.emacs.enable = true;

  security.sudo.enable = true;
  security.sudo.extraRules = [ { commands = [ { command = "${pkgs.systemd}/bin/systemctl"; options = [ "NOPASSWD" ]; } ]; groups = [ "wheel" ]; } ];

  services.acpid.enable = true;

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  services.mysql = {
	  enable = true;
    package = pkgs.mysql80;
    bind = "0.0.0.0";
    dataDir = "/var/db/mysql";
  };

  xdg.portal.enable = true; 
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.glusterfs.killMode = "control-group";
  systemd.watchdog.rebootTime = "30s";
  services.flatpak.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "21.11"; # Did you read the comment?
}







