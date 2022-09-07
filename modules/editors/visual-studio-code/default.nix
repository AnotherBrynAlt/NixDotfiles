{ pkgs, ... }:

{
  programs = {
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        arrterian.nix-env-selector
	bbenoist.nix
	elmtooling.elm-ls-vscode
#        hbenl.vscode-test-explorer
        kamadorueda.alejandra
      ];
    };
  };
}
