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
    ../../user/shell/sh.nix
    ../../user/shell/cli-apps.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    fzf
    bat
    eza
    pass
    wl-clipboard
  ];

  home.sessionVariables = {
    EDITOR = userSettings.editor;
  };
}
