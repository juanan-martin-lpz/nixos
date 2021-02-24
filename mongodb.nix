{ config, pkgs, ... }:

{

  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-4_0;
  };
}
