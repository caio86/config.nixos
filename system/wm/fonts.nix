{ pkgs, ... }:

{
  # Fonts are nice to have
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # Fonts
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Inconsolata" ]; })
      dejavu_fonts
      font-awesome
      noto-fonts-emoji-blob-bin
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [ "DejaVu Sans" ];
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
      };
    };
  };
}

