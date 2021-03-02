# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Drivers
    openrazer-daemon

    # Utilidades del Sistema
    wget
    rxvt_unicode
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
    kubernetes
    #xmonad
    haskellPackages.xmobar
    i3status
    stalonetray
    # Editores de Texto
    vim
    emacs
    emacs-all-the-icons-fonts
    vscode
    #Navegadores
    firefox
    google-chrome
    vivaldi
    vivaldi-ffmpeg-codecs
    # Aplicaciones y Bases de Datos
    libreoffice
    mysql
    sqlite
    # Multimedia
    vlc
    kodi
    steam
    teamspeak_client
    # Lenguajes de Programacion
    nodejs-12_x
    #mongodb-4_2
    #mongodb-compass_1_22
    robo3t
    dropbox
    dropbox-cli
  ];


  #nixpkgs.overlays = [(self: super:
  #  let
  #    unstable = builtins.fetchTarball https://github.com/nixos/nixpkgs-channels/archive/nixos-unstable.tar.gz;
  #    unfreeConfig = config.nixpkgs.config // {
  #      allowUnfree = true;
  #    };
  #  in {

      # emacs = (import unstable { }).emacs;
      # mongodb-4_2 = (import unstable { config = unfreeConfig; }).mongodb-4_2;
      # mongodb-compass = (import /home/blackraider/derivations/mongodb-compass { config = unfreeConfig; });
  #    mongodb-compass_1_22 = super.mongodb-compass.overrideAttrs (oldAttrs: rec {
  #      version = "1.22.1";
  #    });
  # }
  #)];



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
  ];

  # Prettify the virtual console font early on with Terminus.
  console = {
    font = "ter-114n";
    packages = with pkgs; [ terminus_font ];
    earlySetup = true;
  };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./razer.nix
      ./boot.nix
      ./networking.nix
      ./regionals.nix
      ./services.nix
      ./xserver.nix
      #./gnome.nix
      ./xmonad.nix
      ./docker.nix
      #./kubernetes.nix
      ./mongodb.nix
      ./samba.nix
      # ./g13d.nix
      ./dropbox.nix
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


  #Enable VirtualBox

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  #users.extraGroups.vboxusers.members = [ "blackraider" ];

  users.extraUsers.blackraider = {
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  programs.zsh.interactiveShellInit = "export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/";
  programs.zsh.promptInit = "";

  programs.zsh.ohMyZsh = {
    enable = true;
    
    plugins = [ "git" "python" "man" "bower" "cabal" "colorize" "grunt" "gulp" "ng" "npm" "perl" "python" "rails" "ruby" "scala" "screen" "stack" "sudo" "yarn"  ];
    theme = "agnoster";
  };



  security.sudo.enable = true;
  security.sudo.extraRules = [ { commands = [ { command = "${pkgs.systemd}/bin/systemctl"; options = [ "NOPASSWD" ]; } ]; groups = [ "wheel" ]; } ];

  services.acpid.enable = true;

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  services.mysql = {
	enable = true;
	package = pkgs.mariadb;
  };

  xdg.portal.enable = true; 
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.flatpak.enable = true;
 
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?
}







