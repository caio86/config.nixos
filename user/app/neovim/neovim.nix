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
    rev = "7dd5a29a78e24c93393ccb2d1c6aded6ad1f18af";
    hash = "sha256-RsQSWOWfAWJnKfhYZQpg74rKCT9nuRtX9KfSm5yHKW8=";
  };
}
