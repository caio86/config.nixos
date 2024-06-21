{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    unzip
    tree-sitter
    gcc

    xclip
  ];

  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    owner = "caio86";
    repo = "init.lua";
    rev = "b3b491215a14ccf0c9ac82c66f40b76694a76225";
    hash = "sha256-vpnzF3APmAflovgcW+LrdTEb/roU1OHWA5wV/lXuqGA=";
  };
}
