{ pkgs, stylix, userSettings, ... }:


let
  themePath = "../../catppuccin-mocha.yaml";
  backgroundImage = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/m3/wallhaven-m3gxg8.png";
    hash = "sha256-aSgwSZpIRKMdCNYbbpyY3GCb8C8B71SwsH6NYWVA41k=";
  };
in
{
  imports = [ stylix.nixosModules.stylix ];

  stylix.autoEnable = true;
  stylix.polarity = "dark";
  stylix.image = backgroundImage;
  stylix.base16Scheme = ./. + themePath;
}
