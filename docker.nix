{ config, pkgs, ...}:

{
  virtualisation.docker.enable = true;
  users.users.blackraider.extraGroups = [ "docker" ];
}
