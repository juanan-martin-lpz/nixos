{ config, pkgs, ...}:

let
  unstable = import <nixos-unstable> { };
      #unstable = builtins.fetchTarball https://github.com/nixos/nixpkgs-channels/archive/nixos-unstable.tar.gz;
      #unfreeConfig = config.nixpkgs.config // {
      #  allowUnfree = true;
      #};
in {

  imports = [ <nixos/modules/hardware/openrazer.nix> ];
  disabledModules = [ "hardware/openrazer.nix" ];
  hardware.openrazer.enable = true;
}
