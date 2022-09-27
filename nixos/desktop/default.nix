{
  pkgs,
  lib,
  user,
  ...
}: {
  imports =
    [(import ./hardware-configuration.nix)]
    ++ (import ../../modules/hardware)
    ++ [(import ../../modules/hardware/nvidia/default.nix)]
    ++ [(import ../../modules/desktop/plasma/default.nix)];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 10;
    };
  };
}
