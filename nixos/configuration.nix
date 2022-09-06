{ config, lib, pkgs, inputs, user, location, ... }:

{
  imports =
    [
    ];

  networking.hostName = "nixos";

  users.users.${user} = {
  	isNormalUser = true;
  	extraGroups = [ "wheel" "video" "audio" ];
  	shell = pkgs.zsh;
  };

  environment = {
  	variables = {
  	  TERMINAL = "alacritty"; # Wezterm Unavailable in home-manager 22.05
  	  EDITOR = "nvim";
  	  VISUAL = "nvim";
  	};
  	systemPackages = with pkgs; [
      curl
      git
  	  killall
      micro
  	  nano
  	  pciutils
  	  usbutils
  	  wget
  	];
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_CA.utf8";
    LC_IDENTIFICATION = "en_CA.utf8";
    LC_MEASUREMENT = "en_CA.utf8";
    LC_MONETARY = "en_CA.utf8";
    LC_NAME = "en_CA.utf8";
    LC_NUMERIC = "en_CA.utf8";
    LC_PAPER = "en_CA.utf8";
    LC_TELEPHONE = "en_CA.utf8";
    LC_TIME = "en_CA.utf8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  programs.dconf.enable = true;

  fonts.fonts = with pkgs; [
  	source-code-pro
  	jetbrains-mono
  	font-awesome
  	corefonts
  	(nerdfonts.override {
  	  fonts = [
  	    "FiraCode"
  	  ];
  	})
  ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  nix = {
  	settings = {
  		auto-optimise-store = true;
  	};
  	gc = {
  	  automatic = false;
  	};
  	package = pkgs.nixFlakes;
  	registry.nixpkgs.flake = inputs.nixpkgs;
  	extraOptions = ''
  	  experimental-features = nix-command flakes
  	  keep-outputs = true
  	  keep-derivations = true
  	'';
  };

  nixpkgs.config.allowUnfree = true;

  system = {
    stateVersion = "22.05";
  };
}
