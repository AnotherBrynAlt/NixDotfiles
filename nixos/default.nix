{self, ...} @ inputs: let
  system = inputs.flake-utils.lib.system.x86_64-linux;
  nixpkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
  lib = nixpkgs lib;
in {
  # desktop = lib.nixosSystem {
  #   inherit system;
  # };
}
