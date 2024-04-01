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
    rev = "f9d1a01ce5912f6628016724a9434366565bac39";
    hash = "sha256-fRbhmEHFPqh94GHriJSe/XM5EFK9TXlxlZ6IpvSXhlM=";
  };
}
