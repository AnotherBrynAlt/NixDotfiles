{ config, pkgs, inputs, nur, nixgl, alejandra, user, ... }:

{
  imports = 
    (import ../modules/commandline) ++
    (import ../modules/editors) ++
    (import ../modules/shells) ++
    [(../modules/editors/visual-studio-code/default.nix)];

  home = {
    packages = with pkgs; [
      (import nixgl {inherit pkgs; }).nixGLIntel
      hello
    ];
    
    pointerCursor = {
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
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
      keep-derivations = true
    '';
  };
  nixpkgs.config.allowUnfree = true;
  # there is a bug in nixpkgs that prevents the global
  # "allow unfree" from working, so instead just specify
  # a callback that says yes every time something asks
  # if it can install a package with a proprietary license
  # <https://github.com/nix-community/home-manager/issues/2942>
  nixpkgs.config.allowUnfreePredicate = _: true;
}
