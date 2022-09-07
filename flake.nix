{
  description = "Desktop NixOS Flake";

  inputs = {
    nixpkgs = {
      # url = "github:NixOS/nixpkgs/nixos-22.05";
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
      
    home-manager = {
      # url = "github:nix-community/home-manager/release-22.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nur, nixgl, alejandra, ... }:
    let
      user = "bryn";
      location = "$HOME/.dotfiles";
    in {
      nixosConfigurations = (
        import ./nixos {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nur alejandra user location;
        }
      );

      homeConfigurations = (
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs home-manager nixgl nur alejandra user;
        }
      );
    };
}
