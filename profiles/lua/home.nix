{ config, pkgs, userSettings, inputs, ... }:

let
  secretsFile = ../../secrets.yaml;
  homeDirectory = config.home.homeDirectory;
in
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
    ../../user/app/tmux/tmux.nix
    ../../user/shell/sh.nix
    ../../user/shell/cli-apps.nix
    inputs.sops-nix.homeManagerModules.sops
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  sops = {
    age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = "${secretsFile}";
    validateSopsFiles = false;

    secrets = {
      "ssh_keys/lua" = {
        path = "${homeDirectory}/.ssh/id_lua_test";
      };
    };
  };

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

