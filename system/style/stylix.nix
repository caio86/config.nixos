{ pkgs, stylix, userSettings, ... }:

let
  backgroundImage = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/m3/wallhaven-m3gxg8.png";
    hash = "sha256-aSgwSZpIRKMdCNYbbpyY3GCb8C8B71SwsH6NYWVA41k=";
  };
in
{
  imports = [ stylix.nixosModules.stylix ];

  stylix.autoEnable = false;
  stylix.polarity = "dark";
  stylix.image = backgroundImage;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${userSettings.theme}.yaml";

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 24;

  stylix.fonts = {
    monospace = {
      name = "JetBrainsMono Nerd Font Mono";
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
    };
    sansSerif = {
      name = "DejaVu Sans";
      package = pkgs.dejavu_fonts;
    };
    serif = {
      name = "DejaVu Serif";
      package = pkgs.dejavu_fonts;
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-emoji-blob-bin;
    };
  };

  stylix.targets.grub.enable = false;

  stylix.targets.console.enable = false;
}
