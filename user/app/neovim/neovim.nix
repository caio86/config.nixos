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
    rev = "6edbbf65731fa1fa26419fc8a129157d1efd2693";
    hash = "sha256-cnf6qLIFE4B3Y/dNFtgL43iLAAXTpPQkFPVoFP1fwJk=";
  };
}
