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
    rev = "673554cd6222053e7d11a8debf34e6ebc774f1b8";
    hash = "sha256-Q3QhMy7b2X77LORVYI1xVd2qCXtZvK7XsGkHlsoXJRc=";
  };
}
