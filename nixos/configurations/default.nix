{self, ...} @ inputs: {
  desktop = inputs.nixpkgs-unstable.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
    };
    modules = [
      ./desktop
    ];
  };
}
