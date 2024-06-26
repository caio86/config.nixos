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
    rev = "bf9c7c6c549f4ceee30fa4ad839ac8a23efc4746";
    hash = "sha256-DfIx3Jg+EkIpXNvrNXgbCqqhzdAGSsW4wOTU7TRcT4o=";
  };
}
