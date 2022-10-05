{self, ...} @ inputs: {
  desktop = inputs.nixpkgs-unstable.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
    };
    modules = [
      ./desktop

      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            user = "bryn";
          };
          users."bryn" = {
            imports =
              [(import ./home-manager.nix)]
              ++ [(import ./desktop/home-manager.nix)];
          };
        };
      }
    ];
  };
}
