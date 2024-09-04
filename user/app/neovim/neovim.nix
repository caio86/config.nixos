{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      ripgrep
      fd
      unzip
      tree-sitter
      gcc
    ];
  };

  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    owner = "caio86";
    repo = "init.lua";
    rev = "6edbbf65731fa1fa26419fc8a129157d1efd2693";
    hash = "sha256-cnf6qLIFE4B3Y/dNFtgL43iLAAXTpPQkFPVoFP1fwJk=";
  };
}
