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
    rev = "6a096c1b9480390d9cef9d409a33a4fafadc21d5";
    hash = "sha256-pL5oeisacPioALL9Lxticn+TqPVWf1HpEiF0s/oPMDk=";
  };
}
