{ pkgs, ... }:

{
  programs = {
  	wezterm = {
  	  enable = true;
  	  extraConfig = ''
  	  '';
  	};
  };
}