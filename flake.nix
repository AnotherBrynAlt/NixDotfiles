{
  description = "Bryn/Sof NixOS Flake";

  inputs = {
    # Declarative Configuration of Userland
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Build System
    nix = {
      url = "github:nixos/nix";
    };

    # NixGL For Non-NixOS Hardware Acceleration
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixpkgs-2205 = {
      url = "github:NixOS/nixpkgs/nixos-22.05";
    };

    nixpkgs-master = {
      url = "github:NixOS/nixpkgs/master";
    };

    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = {self, ...} @ inputs:
    with inputs; {
      # nix flake check - https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake-check.html
      checks = {
      };

      # Dev Shell with NixL Formatting and Testing Tools
      devShells = {
        x86_64-linux.default = nixpkgs-unstable.legacyPackages.x86_64-linux.mkShell {
          packages = with nixpkgs-unstable.legacyPackages.x86_64-linux; [
            alejandra
            nil
            statix
          ];
        };
      };

      # nix fmt - https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-fmt.html
      formatter = {
        x86_64-linux = nixpkgs-unstable.legacyPackages.x86_64-linux.alejandra;
      };

      # homeConfigurations = import ./home inputs;

      nixosConfigurations = import ./nixos/configurations inputs;
    };
}
