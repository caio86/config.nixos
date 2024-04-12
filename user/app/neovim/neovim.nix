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
    rev = "1ccf4596b1ce33e282ecf5ecd3b0f3ecc25a2160";
    hash = "sha256-e3yGpQw0k5iw+pwU9rk7E0T28IOPaxsTf3HkYOaMxJQ=";
  };
}
