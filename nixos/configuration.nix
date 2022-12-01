{
  config,
  lib,
  pkgs,
  inputs,
  user,
  location,
  ...
}: {
  imports = [
  ];

  networking.hostName = "nixos";

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video" "audio"];
    shell = pkgs.zsh;
  };

  environment = {
    variables = {
      TERMINAL = "wezterm"; # Wezterm Unavailable in home-manager 22.05
      EDITOR = "hx";
      VISUAL = "hx";
      MOZ_USE_XINPUT2 = "1";
      MOZ_ENABLE_WAYLAND = "1";
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
        "Meslo"
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
    package = pkgs.nixUnstable;
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = false;
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    #    (self: super: {
    #     discord = super.discord.override {withOpenASAR = true;};
    #  })
  ];

  system = {
    stateVersion = "22.05";
  };
}
