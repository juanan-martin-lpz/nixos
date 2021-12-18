{ config, pkgs, ... }:

{

  # Boot Options



  boot.kernelModules  = [ "coretemp" "nct6775" ];
  boot.kernelParams = [ "vga=0x31b" ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.copyKernels = true;
  boot.supportedFilesystems = [ "ext2" "ext3" "ext4" "ntfs" "vfat" "fat32" ];

  # Define on which hard drive you want to install Grub.
  boot.loader.grub.devices = [ "/dev/sdb" ]; # or "nodev" for efi only


  # Desde https://github.com/angristan/nixos-config/blob/master/configuration.nix
  
  # systemd-boot
  boot.loader.systemd-boot.enable = true;
  # Bigger console font
  boot.loader.systemd-boot.consoleMode = "auto";
  # Clear /tmp during boot
  boot.cleanTmpDir = true;
  
}
