{
  description = "Desktop NixOS Flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-22.05";
    };
      
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };
  };

  outputs = inputs @ { nixpkgs, home-manager, nur, ... }:
    let
      user = "bryn";
      location = "$HOME/.dotfiles";
    in {
      nixosConfigurations = (
        import ./nixos {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur user location;
        }
      );
    };
}
