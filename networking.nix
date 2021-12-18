{ config, pkgs, ... }:

{

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.

  networking.firewall.enable = true;

  networking.nameservers = [
    "212.230.135.1"
    "212.230.135.2"
    "172.19.0.2"
  ];
  
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.hostName = "Gorgona"; # Define your hostname.
  networking.hostId = "cabe207a";

  # KDE Connect
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 1714;
      to = 1764;
    }
  ];


  networking.firewall.allowedUDPPortRanges  = [
    {
      from = 1714;
      to = 1764;
    }
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 8080];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}
