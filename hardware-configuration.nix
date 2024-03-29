# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Desde https://github.com/angristan/nixos-config/blob/master/configuration.nix
  
  # Enable microcode updates for Intel CPU
  hardware.cpu.intel.updateMicrocode = true;
  # Enable all the firmware
  hardware.enableAllFirmware = true;
  # Enable all the firmware with a license allowing redistribution. (i.e. free firmware and firmware-linux-nonfree)
  hardware.enableRedistributableFirmware = true;
  # Enable OpenGL drivers
  hardware.opengl.enable = true;
  
  #hardware.logitech.lcd.enable = true;
  
  
  fileSystems."/" =
    { device = "/dev/sdb1";
      fsType = "ext4";
    };

  
  fileSystems."/mnt/Datos" = 
    { device = "/dev/sdd1";
      fsType = "ntfs";
    };

  fileSystems."/mnt/Externo" =
    { device = "/dev/sde1";
      fsType = "ntfs";
    };

  fileSystems."/mnt/Externo2" =
    { device = "/dev/sde2";
      fsType = "ext4";
    };

  fileSystems."/mnt/C" =
    { device = "/dev/nvme0n1p2";
      fsType = "ntfs";
    };


  fileSystems."/mnt/D" =
    { device = "/dev/sda1";
      fsType = "ntfs";
    };

  fileSystems."/mnt/G" =
    { device = "/dev/sdc2";
      fsType = "ntfs";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 12;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
