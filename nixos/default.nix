{
  lib,
  attributes,
  nixpkgs,
  home-manager,
  nur,
  user,
  location,
  alejandra,
  rnix-lsp,
  ...
}: let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in {
  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit attributes user location;
    };
    modules = [
      {
        environment.systemPackages = [alejandra.defaultPackage.${system} rnix-lsp.defaultPackage.${system}];
      }
      nur.nixosModules.nur
      ./desktop
      ./configuration.nix

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user;
        };
        home-manager.users.${user} = {
          imports =
            [(import ./home-manager.nix)]
            ++ [(import ./desktop/home-manager.nix)];
        };
      }
    ];
  };
}
