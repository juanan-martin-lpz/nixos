{ config, pkgs, ... }:

{

  # GNOME
  services.xserver = {
	  #GNOME
	  desktopManager = {
		  # default = "none";
		  gnome3.enable = true;
	  };

	  #GNOME
	  displayManager = {
		  gdm.enable = true;
	  };
  };

  environment.systemPackages = with pkgs; [
    # GNOME
    gnome3.adwaita-icon-theme
    gnome3.gnome-boxes
    gnome3.gnome-control-center
    gnome3.gnome-books
    gnome3.gnome-desktop
    gnome3.gnome-initial-setup
    gnome3.gnome-session
    gnome3.gnome-shell
    gnome3.gnome-packagekit flatpak
    chrome-gnome-shell
  ];

  #GNOME
  services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];
  services.dbus.packages = [ pkgs.gnome3.dconf pkgs.gnome2.GConf ];
  services.gnome3.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  programs.dconf.enable = true;

}
