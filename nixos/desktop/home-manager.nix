{pkgs, ...}: {
  imports =
    (import ../../modules/internet)
    ++ [(import ../../modules/services/flameshot/default.nix)]
    ++ [(import ../../modules/editors/visual-studio-code/default.nix)];

  home = {
    packages = with pkgs; [
      gimp
    ];
  };
}
