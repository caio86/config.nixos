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
    rev = "330425e9e787283ed0c3086a54c150aefc15cf03";
    hash = "sha256-5aQvXihUXsQqI2/XFn8ZIod+gOZe+sJiyQywIsVrmk0=";
  };
}
