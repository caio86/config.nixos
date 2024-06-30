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
    rev = "fa38e1446897d8863254ee0588f5bfd65a1c23c8";
    hash = "sha256-xIK+exyQ6zjzszWmIS1hjIS7SBzphY79YgcomXr6YBo=";
  };
}
