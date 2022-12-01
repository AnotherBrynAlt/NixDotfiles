{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
    };
  };
  environment.gnome.excludePackages = (with pkgs; [
    pkgs.gnome.seahorse
  ]);
}
