{ pkgs, ... }:

{
  programs = {
    just = {
      enable = true;
      enableZshIntegration = false;
    };
  };
}
