{
  lib,
  inputs,
  nixpkgs,
  nixpkgs-master,
  home-manager,
  nur,
  user,
  location,
  ...
}: let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [(self: super: {discord = super.discord.override {withOpenASAR = true;};})];
  };

  lib = nixpkgs.lib;
in {
  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user location;
    };
    modules = [
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
  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs user location;
    };
    modules = [
      nur.nixosModules.nur
      ./laptop
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
            ++ [(import ./laptop/home-manager.nix)];
        };
      }
    ];
  };
}
