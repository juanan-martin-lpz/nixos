{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.consoleMode = "1";

  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "es_ES.UTF-8";
    #consoleUseXkbConfig = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Madrid";
}
