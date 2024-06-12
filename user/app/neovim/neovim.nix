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
    rev = "e5592ef32d75cd647b7aa7de28ae8b2dbde75847";
    hash = "sha256-pNXeP0/hyhdmiWBTGhIKjZcIiRNiFEgAsozuSCldl0w=";
  };
}
