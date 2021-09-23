# Configuration for my xmonad desktop requirements

{ config, pkgs, ... }:

{
  services.httpd = {
    enable = true;
    # hostName = "localhost";

    logPerVirtualHost = true;
    adminAddr = "postmaster@localhost";
    # documentRoot = "/var/www/htdocs";
    enablePHP = true;

    phpOptions = ''
	  upload_max_filesize = 20M	
 	  post_max_size = 20M
    '';

    extraModules = [ "http2" "ssl" 
		                 { name="php7"; path = "${pkgs.php}/modules/libphp7.so";}
		                 { name = "deflate"; path = "${pkgs.apacheHttpd}/modules/mod_deflate.so"; }
                     { name = "proxy_wstunnel"; path ="${pkgs.apacheHttpd}/modules/mod_proxy_wstunnel.so"; } ];

    virtualHosts = {
      localhost = {
        documentRoot = "/var/www/htdocs";
      };
    };

    extraConfig = ''

	<Directory /var/www/htdocs>
    		Options Indexes FollowSymLinks
    		AllowOverride All
    		Require all granted
	</Directory> 

	<IfModule mime_module>

    		AddType text/html .php .phps

	</IfModule>

	<FilesMatch "\.php$">

    		SetHandler application/x-httpd-php

	</FilesMatch>

	<FilesMatch "\.phps$">

    		SetHandler application/x-httpd-php-source

	</FilesMatch>

	    Alias /phpmyadmin "/var/www/phpmyadmin/"

    	<Directory "/var/www/phpmyadmin">

        	AllowOverride AuthConfig

        	Require local

        	ErrorDocument 403 /error/XAMPP_FORBIDDEN.html.var

    	</Directory>

      <Directory / >

  		     Options Indexes FollowSymLinks

           #AllowOverride FileInfo 

           AllowOverride All
           Order allow,deny
           Allow from all
           <IfModule mod_rewrite.c>

            ## subdirectory
            RewriteEngine On
            RewriteBase /
            RewriteRule ^index\.php$ - [L]

            ## add a trailing slash to /wp-admin
            RewriteRule ^([_0-9a-zA-Z-]+/)?wp-admin$ $1wp-admin/ [R=301,L]

            RewriteCond %{REQUEST_FILENAME} -f [OR]
            RewriteCond %{REQUEST_FILENAME} -d
            RewriteRule ^ - [L]
            RewriteRule ^([_0-9a-zA-Z-]+/)?(wp-(content|admin|includes).*) $2 [L]
            RewriteRule ^([_0-9a-zA-Z-]+/)?(.*\.php)$ $2 [L]
            RewriteRule . index.php [L]
            </IfModule>
       </Directory>

	    #ErrorLog "/home/blackraider/www/logs/error.log"

            # both cases needed
            <IfModule mod_dir.c>
              DirectoryIndex index.php index.htm index.html
            </IfModule>

   '';
  };


#  services.httpd = {
#    enable = true;
#    hostName = "localhost";
#    logPerVirtualHost = true;
#    adminAddr = "postmaster@localhost";
#    extraModules = [ "http2"  
#		{ name="php7"; path = "${pkgs.php}/modules/libphp7.so";}
#		{ name = "deflate"; path = "${pkgs.apacheHttpd}/modules/mod_deflate.so"; }
#      		{ name = "proxy_wstunnel"; path ="${pkgs.apacheHttpd}/modules/mod_proxy_wstunnel.so"; } ];
#
#
#    extraConfig = ''
#	<Directory /var/www/htdocs>
#    		Options Indexes FollowSymLinks
#    		AllowOverride All
#    		Require all granted
#	</Directory> 
#
#	<IfModule mime_module>
#
#    		AddType text/html .php .phps
#
#	</IfModule>
#
#	<FilesMatch "\.php$">
#
#    		SetHandler application/x-httpd-php
#
#	</FilesMatch>
#
#	<FilesMatch "\.phps$">
#
#    		SetHandler application/x-httpd-php-source
#
#	</FilesMatch>
#
#	Alias /phpmyadmin "/var/www/phpmyadmin/"
#
#    	<Directory "/var/www/phpmyadmin">
#
#        	AllowOverride AuthConfig
#
#        	Require local
#
#        	ErrorDocument 403 /error/XAMPP_FORBIDDEN.html.var
#
#    	</Directory>
#   '';
#
#    #configFile = "/home/blackraider/httpd/httpd.conf"; 
#    enablePHP = true;
#
#    virtualHosts =
#    [
#      {
#	hostName = "localhost";
#	documentRoot = "/var/www/htdocs";
#
#        extraConfig = '' 
#            <Directory / >
#		Options Indexes FollowSymLinks
#        	AllowOverride FileInfo 
#
#           <IfModule mod_rewrite.c>
#
#            ## subdirectory
#            RewriteEngine On
#            RewriteBase /
#            RewriteRule ^index\.php$ - [L]
#
#            ## add a trailing slash to /wp-admin
#            RewriteRule ^([_0-9a-zA-Z-]+/)?wp-admin$ $1wp-admin/ [R=301,L]
#
#            RewriteCond %{REQUEST_FILENAME} -f [OR]
#            RewriteCond %{REQUEST_FILENAME} -d
#            RewriteRule ^ - [L]
#            RewriteRule ^([_0-9a-zA-Z-]+/)?(wp-(content|admin|includes).*) $2 [L]
#            RewriteRule ^([_0-9a-zA-Z-]+/)?(.*\.php)$ $2 [L]
#            RewriteRule . index.php [L]
#            </IfModule>
#            </Directory>
#	    
#	    ErrorLog "/var/log/error.log"
#
#            # both cases needed
#            <IfModule mod_dir.c>
#              DirectoryIndex index.php index.htm index.html
#            </IfModule>
#        '';
# 
#      }
#      {
#        hostName = "testthemes";
#        documentRoot = "/var/www/htdocs/testthemes";
#        
#	enableSSL = true;
#        sslServerKey = "/home/blackraider/certs/key.pem";
#        sslServerCert = "/home/blackraider/certs/cert.pem";
#
#
#        extraConfig = '' 
#		ErrorLog "/var/log/error.log"
#
#		    DirectoryIndex index.php
#		
#		        <Directory /var/www//htdocs/testthemes/>
#		            Options FollowSymLinks
#		            AllowOverride None
#		            Order deny,allow
#		            Allow from all
#		        </Directory>
#		
#		  	<Files wp-login.php>
#				Order Deny,Allow
#				Allow from 127.0.0.1 
#				Deny from All
#			</Files>
#		
#		        <Directory /var/www/htdocs/testthemes/wp-admin>
#		            Options FollowSymLinks
#		            AllowOverride None
#		            Order Deny,Allow
#		            Allow from 127.0.0.1
#		            Deny from All
#		        </Directory>
#		
#			<Filesmatch  ^wp-config.php$>
#				Deny from all
#			</Filesmatch>
#		
#			<Directory /var/www/blog/htdocs/wp-content/plugins>
#				DirectorySlash Off
#			</Directory>	
#
#           <IfModule mod_rewrite.c>
##
#	    ## add a trailing slash to /wp-admin
#            RewriteRule ^([_0-9a-zA-Z-]+/)?wp-admin$ $1wp-admin/ [R=301,L]
##
#            RewriteCond %{REQUEST_FILENAME} -f [OR]
#            RewriteCond %{REQUEST_FILENAME} -d
#            RewriteRule ^ - [L]
#            RewriteRule ^([_0-9a-zA-Z-]+/)?(wp-(content|admin|includes).*) $2 [L]
#            RewriteRule ^([_0-9a-zA-Z-]+/)?(.*\.php)$ $2 [L]
#            RewriteRule . /testthemes/index.php [L]
#            </IfModule>
#
#            # both cases needed
#            <IfModule mod_dir.c>
#              DirectoryIndex index.php index.htm index.html
#            </IfModule>
#        '';
#      }
#   ];
#  };

  #users.users.http =
  #{
  #  isNormalUser = true;
  #  home = "/etc/user/http";
  #};
}
