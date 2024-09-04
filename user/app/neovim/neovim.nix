{ pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      ripgrep
      fd
      unzip
      tree-sitter
      gcc
    ];
  };

  xdg.configFile."nvim".source = inputs.neovim-config;
}
