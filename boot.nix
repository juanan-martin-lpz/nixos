{ config, pkgs, ... }:

{

  # Boot Options
  
  boot.kernelModules  = [ "coretemp" "nct6775" ];
  boot.kernelParams = [ "vga=0x367" ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.copyKernels = true;
  boot.supportedFilesystems = [ "ext2" "ext3" "ext4" "ntfs" "vfat" "fat32" ];

  # Define on which hard drive you want to install Grub.
  boot.loader.grub.devices = [ "/dev/sdb" ]; # or "nodev" for efi only
}
