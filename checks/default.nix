{
  inputs,
  system,
}: let
  pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
  alejandraPackages = inputs.alejandra.packages.${system};
  callPackage = pkgs.lib.callPackageWith (inputs // pkgs // alejandraPackages);
in {
  alejandra = callPackage ./alejandra.nix {};
}
