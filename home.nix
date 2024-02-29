{ config, pkgs, lib, userSettings, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./sh.nix
    ./git.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    ripgrep
    fzf
    fd
    bat
    eza
    pass
    wl-clipboard
    discord
    whatsapp-for-linux
    brave
  ];

  programs.neovim = {
  enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      LazyVim
    ];
  };
  
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Músicas";
    videos = "${config.home.homeDirectory}/Media/Vídeos";
    pictures = "${config.home.homeDirectory}/Media/Imagens";
    templates = "${config.home.homeDirectory}/Modelos";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documentos";
    desktop = null;
    publicShare = null;
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.configFile.nvim.source = pkgs.fetchFromGitHub {
    owner = "caio86";
    repo = "config.nvim";
    rev = "b727bd8dc911d0cf79df12603e0572e6461df6ec";
    hash = "sha256-+4qowRbs86yvNKxLj2TY9krGI6JN+13E900x+9ukZk8=";
  };

  home.sessionVariables = {
    EDITOR = userSettings.editor;
  };
}
