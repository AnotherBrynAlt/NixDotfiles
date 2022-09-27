inputs:
inputs.flake-utils.lib.eachDefaultSystem (
  system: let
    pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
    alejandraPackages = inputs.alejandra.legacyPackages.${system};
    callPackage = pkgs.lib.callPackageWith (pkgs // alejandraPackages // {inherit (inputs) self;});
  in {
    alejandra = callPackage ./alejandra.nix {};
  }
)
