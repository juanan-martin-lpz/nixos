{ config, pkgs, ... }:

{
  services.nginx = {
    user = "blackraider";
    group = "users";
    enable = true;

    virtualHosts."localhost" = {
      #enableACME = true;
      #forceSSL = true;
      root = "/var/www/htdocs";
      locations."~ \.php$".extraConfig = ''
                   fastcgi_pass  unix:${config.services.phpfpm.pools.mypool.socket};
                   fastcgi_index index.php;
                   index index.html index.htm index.php
                   allow 192.168.1.1/24;
                   deny all;
                   autoindex on;
                   autoindex_exact_size off;
                   '';
    };

  };

  services.phpfpm.pools.mypool = {
    user = "nobody";
    settings = {
      pm = "dynamic";
      "listen.owner" = config.services.nginx.user;
      "pm.max_children" = 5;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 1;
      "pm.max_spare_servers" = 3;
      "pm.max_requests" = 500;
    };
  };
}
