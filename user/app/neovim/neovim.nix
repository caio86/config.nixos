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
    rev = "b7d4c09497f21df56c6f9b8963e86190bc8fc32a";
    hash = "sha256-nfFBXDlJnreE5+4692RixTntrMT8Qa33Hq2dyAz6hfk=";
  };
}
