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
    rev = "e6e15ba78f844cb828fb5fa4abe9075a2a43b4a1";
    hash = "sha256-TggNcvqZQB+y0/uryNjwL1nq20hrReRNFRio3gafVto=";
  };
}
