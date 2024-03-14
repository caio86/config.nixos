{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
  };

  home.packages = with pkgs; [
    ripgrep fd
    unzip
    tree-sitter gcc

    xclip
  ];

  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    owner = "caio86";
    repo = "init.lua";
    rev = "7ec0079e572427024c1d81f13e08cd43bcc66075";
    hash = "sha256-FCEqMzeIABXiq4C1DyrnujCF6cietJa+KZxGxqax/lA=";
  };
}
