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
    rev = "439d789359f470e3cd9445ea0450c0f635c3ebf0";
    hash = "sha256-kR51zxjXoPjdgM7mqFFwYaofNjI1F6QdOVIw4gw+M6s=";
  };
}
