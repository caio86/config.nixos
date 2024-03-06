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
    wl-clipboard
  ];

  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    owner = "caio86";
    repo = "init.lua";
    rev = "21ea8ba6334f856ea3ea37e0e5cb51f30c324d5d";
    hash = "sha256-d/Uzdq7bO2CDvbm1WG8pDnFzjE79TIJ6GjvOudesCJc=";
  };
}
