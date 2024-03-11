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

    xclip
  ];

  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    owner = "caio86";
    repo = "init.lua";
    rev = "477431222ab92f1cb581753c2cc3cbbe5a4104bd";
    hash = "sha256-wlLe4kKi8Ka+7xSNV7NwlAhjeVI3mTI5DET0+lrs5i8=";
  };
}
