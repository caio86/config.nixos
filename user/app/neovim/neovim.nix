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
    rev = "b68908ccd18d872be7daac248a9e85bdce0e2b15";
    hash = "sha256-asttjL1BwW/li7JVKAvmd36QvA06Ph9mfBFWSaJogCY=";
  };
}
