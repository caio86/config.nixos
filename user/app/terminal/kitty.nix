{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    kitty
    kitty-themes
  ];

  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 10;
    };
    theme = "Catppuccin-Mocha";
    settings = {
      background_opacity = lib.mkForce "0.75";
      # tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
  };
}
