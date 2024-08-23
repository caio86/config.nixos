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
    rev = "fa8c573131c572ffa963ffb2d23f675752e953d0";
    hash = "sha256-SrEZaqi6Mmxig7xu4mr1m9b4CIAxUXZUMdIpUwwK5xU=";
  };
}
