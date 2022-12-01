{ pkgs, ... }:

{
  imports =
    (import ../../modules/internet) ++
    [(import ../../modules/editors/visual-studio-code/default.nix)];

  home = {
    packages = with pkgs; [
    ];
    pointerCursor = {
      x11.enable = true;
      size = 32;
    };
  };
}
