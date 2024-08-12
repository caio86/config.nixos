{ pkgs, ... }:

{
  # Fonts are nice to have
  fonts.packages = with pkgs; [
    # Fonts
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Inconsolata" ]; })
    font-awesome
  ];
}

