{ lib, inputs, nixpkgs, home-manager, nur, nixgl, alejandra, user, ... }:

let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config = {
      alowUnfree = true;
      # there is a bug in nixpkgs that prevents the global
      # "allow unfree" from working, so instead just specify
      # a callback that says yes every time something asks
      # if it can install a package with a proprietary license
      # <https://github.com/nix-community/home-manager/issues/2942>
      # nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowUnfreePredicate = _: true;
    };
  }; 
in {
  crostini = home-manager.lib.homeManagerConfiguration {
#    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    inherit pkgs;
    modules = [
      ./crostini.nix
      {
        home = {
          username = "${user}";
          homeDirectory = "/home/${user}";
          stateVersion = "22.11";
        };
      }
    ];
    extraSpecialArgs = { inherit inputs nur nixgl alejandra user; }; 
  };
}
