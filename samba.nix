{ config, pkgs, ... }:

{

  services.samba = {
   enable = true;
   securityType = "user";
   extraConfig = ''
    workgroup = WORKGROUP
    server string = smbnix
    netbios name = smbnix
    security = user
  '';
  shares = {
    private = {
      path = "/mnt/Externo/Downloads";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "yes";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "blackraider";
      "force group" = "users";
    };
   };
  };

  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 445 139 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];

}
