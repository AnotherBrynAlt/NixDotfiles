{pkgs, ...}: {
  programs = {
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        arrterian.nix-env-selector
        jnoortheen.nix-ide
        # hbenl.vscode-test-explorer
        kamadorueda.alejandra
      ];
      userSettings = {
        "nix.enableLanguageServer" = true;
      };
    };
  };
}
