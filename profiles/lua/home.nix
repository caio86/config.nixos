{ inputs, pkgs, userSettings, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "caiol";
  home.homeDirectory = lib.mkDefault "/home/caiol";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ../../user/app/git/git.nix
    ../../user/app/neovim/neovim.nix
    ../../user/app/tmux/tmux.nix
    ../../user/shell/sh.nix
    ../../user/shell/cli-apps.nix
    # ../../user/style/stylix.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  # stylix.autoEnable = lib.mkForce false;

  sops = {

    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;

    age.keyFile = "/home/caiol/.config/sops/age/keys.txt";

    secrets = {
      "ssh_keys/lua" = {
        path = "/home/caiol/.ssh/id_lua";
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

