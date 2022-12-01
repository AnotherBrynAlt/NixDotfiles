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
      displayManager = {
        sddm = {
          enable = true;
        };
        sessionPackages = [
          (pkgs.plasma-workspace.overrideAttrs
            (old: {passthru.providedSessions = ["plasmawayland" "plasma"];}))
        ];
      };
      desktopManager = {
        plasma5 = {
          enable = true;
        };
      };
    };
  };
}
