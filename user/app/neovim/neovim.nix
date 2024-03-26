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
    rev = "940f4def7a7343b4ec642f2599311a721e9db0e8";
    hash = "sha256-D6iV8UjNls8twLZyPhmcoJ/EJkTznL7a+wHyxXvUfsQ=";
  };
}
