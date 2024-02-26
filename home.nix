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
  fzfd = ''
    escolhido=$(fd -t d | fzf)
    if [ -z "$escolhido" ]; then
      return 0
    fi

    cd $escolhido
  '';
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
      fzf
      fd
    ];

  # programs.neovim = {
  # enable = true;
  #   vimAlias = true;
  #   plugins = with pkgs.vimPlugins; [
  #     LazyVim
  #   ];
  # };

  programs.starship.enable = true;
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = myAliases;
    oh-my-zsh = {
      enable = true;
      plugins = [
       "git"
       "git-auto-fetch"
       "command-not-found"
       "sudo"
       "aliases"
      ];
    };
  };

programs.git = {
  enable = true;
  userName = "caio86";
  userEmail = "caioluiz86@gmail.com";
  extraConfig = {
    init.defaultBranch = "main";
    credential.helper = "cache --timeout=7200";
    core = {
      autocrlf = false;
      eol = "lf";
      editor = "vim";
    };
  };
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
