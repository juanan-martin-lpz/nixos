{ config, pkgs, ... }:

{
  services.kubernetes.apiserver.insecurePort = 8080;
  services.kubernetes.apiserver.insecureBindAddress = "localhost";
  services.kubernetes.roles = [ "master" "node" ];
  services.kubernetes.masterAddress = "localhost";
}
