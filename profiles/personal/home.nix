{ config, pkgs, lib, userSettings, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ../../user/app/git/git.nix
    ../../user/app/neovim/neovim.nix
    ../../user/app/terminal/kitty.nix
    ../../user/app/tmux/tmux.nix
    ../../user/shell/sh.nix
    ../../user/shell/cli-apps.nix
    ../../user/wm/hyprland/hyprland.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    fzf
    bat
    eza
    pass
    wl-clipboard
    (nerdfonts.override { fonts = [ "JetBrainsMono" "IntelOneMono" ]; })
  ];

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

  home.sessionVariables = {
    EDITOR = userSettings.editor;
  };
}
