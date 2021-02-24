{ config, pkgs, ...}:

let g13d = import ./pkgs/g13d {};
in config.systemd.services.g13d = {
  description = "Logitech G13 Daemon";
  after = ["network.target"];
  wantedBy = ["multi-user.target"];

  serviceConfig = {
    # change this to refer to your actual derivation
    ExecStart = "${g13d}/bin/syslog-exec.sh";
    Restart = "always";
    RestartSec = 1;
  }
}
