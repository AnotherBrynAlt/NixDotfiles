{
  description = "Bryn/Sof NixOS Flake";

  inputs = {
    # Opinionated NixL Formatter
    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Useful Flake Functions
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    # Declarative Configuration of Userland
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # NixL LSP
    nil = {
      url = "github:oxalica/nil";
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

    # NixL Static Analyzer and Linter
    statix = {
      url = "github:nerdypepper/statix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = {self, ...} @ inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system: let
        nixpkgs = inputs.nixpkgs-unstable.legacyPackages.${system};

        user = "bryn";
      in
        with inputs; {
          # nix flake check - https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake-check.html
          checks.${system} = import ./checks inputs;

          # Dev Shell with NixL Formatting Tools
          devShell = nixpkgs.mkShell {
            packages = [
              alejandra.defaultPackage.${system}
              nil.packages.${system}.nil
              statix.defaultPackage.${system}
            ];
          };

          # nix fmt - https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-fmt.html
          formatter.${system} = alejandra.defaultPackage.${system};

          homeConfigurations = import ./home inputs;

          nixosConfigurations = import ./nixos inputs;
        }
    );
}
