{ config, lib, pkgs, user, ... }:

{
  imports =
    (import ../modules/commandline) ++
    (import ../modules/editors) ++
    (import ../modules/services) ++
    (import ../modules/shells) ++
    (import ../modules/terminal-emulators);

  home = {
    stateVersion = "22.05";
  	username = "${user}";
  	homeDirectory = "/home/${user}";

  	packages = with pkgs; [
  	];

  	pointerCursor = {
  	  name = "Dracula-cursors";
  	  package = pkgs.dracula-theme;
  	  size = 16;
  	};
  };

  programs = {
  	home-manager.enable = true;
  };

  gtk = {
  	enable = true;
  	theme = {
  	  name = "Dracula";
  	  package = pkgs.dracula-theme;
  	};
  	iconTheme = {
  	  name = "Papirus-Dark";
  	  package = pkgs.papirus-icon-theme;
  	};
  	font = {
  	  name = "JetBrains Mono Medium";
  	};
  };
}
