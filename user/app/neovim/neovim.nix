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
    rev = "a9c15c48a96397ca8f9b1f4bddea8934128bc5bc";
    hash = "sha256-o4Z2+bc3H3Cx8bLbjxiZp8tWH53NMONtE4en3ct+EgU=";
  };
}
