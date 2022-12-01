{ config, pkgs, inputs, nur, nixgl, alejandra, user, ... }:

{
  imports = 
    (import ../modules/commandline) ++
    (import ../modules/editors) ++
    [(import ../modules/editors/helix/default.nix)] ++
    (import ../modules/shells);

  home = {
    packages = with pkgs; [
      alejandra.defaultPackage."x86_64-linux"
      (import nixgl {inherit pkgs; }).nixGLIntel
      hello
      nil
      rnix-lsp
    ];
    
    sessionVariables = {
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5";
    };
  };
  
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  gtk = {
    enable = false;
  };

  programs = {
    home-manager.enable = true;
    zsh.enable = true;
  };

  nix = {
    package = pkgs.nixUnstable;
    settings = {
      auto-optimise-store = true;
    };
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
