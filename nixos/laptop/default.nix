{
  pkgs,
  lib,
  user,
  ...
}: {
  imports =
    [(import ./hardware-configuration.nix)]
    ++ (import ../../modules/hardware)
    ++ [(import ../../modules/desktop/plasma/default.nix)]
    ++ [(import ../../modules/desktop/gnome/default.nix)];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 10;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "mem_sleep_default=deep"
      #      "snd-intel-dspcfg.dsp_driver=3"
      #      "snd_sof_pci.fw_path=\"intel/sof\""
    ];
    initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };
    #    extraModprobeConfig = ''
    #      options snd-intel-dspcfg dsp_driver=3
    #      options snd_sof_pci fw_path=\"intel/sof\"
    #    '';
  };

  services.printing.enable = true;
  hardware.enableAllFirmware = true;

  services.xserver.dpi = 153;
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  hardware.bluetooth = {
    enable = true;
  };
}
