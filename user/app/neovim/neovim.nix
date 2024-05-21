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
    rev = "b0f54ef3e1ca6797b4a23e14b0343f2090c0a9ed";
    hash = "sha256-eZFI4Say8YjYQHMKAy6SqQc9iOkJs1rXkBhZScgH4nU=";
  };
}
