{ config, pkgs, ... }:

{

  services.samba = {
   enable = true;
   securityType = "user";
   extraConfig = ''
    workgroup = WORKGROUP
    server string = smbnix
    netbios name = smbnix
    disable netbios = yes
    security = user
    hosts allow = 127.0.0. 192.168.1.
    hosts deny = 0.0.0.0/0
  '';

   shares = {
    private = {
      path = "/mnt/Externo2/Downloads";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "blackraider";
      "force group" = "users";
    };

    home = {
      path = "/home/blackraider";
      browseable = "yes";
      "read only" = "no";
      "guest ok" = "no";
      "create mask" = "0644";
      "directory mask" = "0755";
      "force user" = "blackraider";
      "force group" = "users";
    };
   };
  };

  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 445 139 6881 51413 ];
  networking.firewall.allowedUDPPorts = [ 137 138 8881 7881];
  networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';

}
