{ pkgs, stylix, userSettings, ... }:


let
  theme = "catppuccin-mocha";
  backgroundImage = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/m3/wallhaven-m3gxg8.png";
    hash = "sha256-aSgwSZpIRKMdCNYbbpyY3GCb8C8B71SwsH6NYWVA41k=";
  };
in
{
  imports = [ stylix.homeManagerModules.stylix ];

  stylix.autoEnable = false;
  stylix.polarity = "dark";
  stylix.image = backgroundImage;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 24;

  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override {
        fonts = [ "JetBrainsMono" ];
      };
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
  };
}
