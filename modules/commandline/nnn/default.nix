{pkgs, ...}: {
  programs = {
    nnn = {
      enable = true;
      extraPackages = with pkgs; [
        ffmpegthumbnailer
        mediainfo
        sxiv
      ];
    };
  };
}
