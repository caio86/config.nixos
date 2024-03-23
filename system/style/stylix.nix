{ pkgs, stylix, userSettings, ... }:

{
  imports = [ stylix.nixosModules.stylix ];

  stylix.image = ~/wallpapers/doom.jpg;
}
