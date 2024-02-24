{ pkgs, ... }:

let
myAliases = {
  c = "clear";
  # vim = "nvim";
  ls = "eza";
  ll = "eza -lh";
  lsa = "eza -lah";
  l = "eza -lah";
  rg = "rg --smart-case";
  cat = "bat -p";
};

in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "caio";
  home.homeDirectory = "/home/caio";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.11"; # Please read the comment before changing.

    home.packages = with pkgs; [
      eza
      ripgrep
      fd
      bat
    ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      LazyVim
    ];
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = myAliases;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "git-auto-fetch" ];
    };
  };

  programs.starship = {
    enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
