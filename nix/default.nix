{ lib, inputs, nixpkgs, home-manager, nur, nixgl, alejandra, user, ... }:

{
  crostini = home-manager.lib.homeManagerConfiguration {
    system = "x86_64-linux";
    username = "${user}";
    homeDirectory = "/home/${user}";
    configuration = import ./crostini.nix;
    extraSpecialArgs = { inherit inputs nur nixgl alejandra user; }; 
  };
}
