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
  ];

  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    owner = "caio86";
    repo = "init.lua";
    rev = "282d6924ceb101a181f7edb4e46a880313299bc3";
    hash = "sha256-o+eaZat48OcgDWxMUkZOs9mNB0pO2d72koJycRhkp8w=";
  };
}
