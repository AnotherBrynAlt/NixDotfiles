{ pkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
      	font = rec {
      	  normal = {
      	    family = "JetBrains Mono";
      	    style = "Regular";
      	  };
      	  bold = {
      	  	style = "Bold";
      	  };
      	  italic = {
      	    style = "Italic";
      	  };
      	};
      };
    };
  };
}
