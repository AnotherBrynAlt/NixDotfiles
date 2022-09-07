{ config, pkgs, inputs, nur, nixgl, alejandra, user, ... }:

{
  imports = 
    [(../modules/editors/visual-studiocode/default.nix)];

  home = {
    packages = with pkgs; [
      (import nixgl {inherit pkgs; }).nixGLIntel
      hello
    ];
  };

  programs = {
    home-manager.enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep derivations = true
    '';
  };
  nixpkgs.config.allowUnfree = true;
}
