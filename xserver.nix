{ config, pkgs, ... }:

{

  # Servidor X
  services.xserver = {
	  videoDrivers = [ "nvidia" ];
	  enable = true;
	  layout = "us";

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

	  #xkbOptions = "eurosign:e";
  };
}
