{ config, pkgs, ... }:

{

  # services.picom.enable = true;
  services.dbus.enable = true;

  services.upower.enable = true;
  services.udisks2.enable = true;

  # Servidor X
  services.xserver = {
	  videoDrivers = [ "nvidia" ];
	  enable = true;
	  layout = "us";

    updateDbusEnvironment = true;
    
    moduleSection = ''
        Load "extmod"
        Load "dbe"
        Load "type1"
        Load "freetype"
        Load "glx"
    '';

  	screenSection = ''
          Option  "RegistryDwords" "PowerMizerEnable=0x1; PerfLevelSrc=0x3322; PowerMizerDefaultAC=0x1"
    '';


    desktopManager.plasma5.enable = true;

    displayManager.sddm.enable = true;

    displayManager.lightdm.enable = false;

    displayManager.hiddenUsers = [
      "blacky"
    ];

  };
}
