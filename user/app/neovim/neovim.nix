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
    rev = "91fe6fd7d954953f1b5facc897949c71318571e3";
    hash = "sha256-ruujXOTVAJatdM+wbTX3lexC8owGzHJVNAJnlESWUPM=";
  };
}
