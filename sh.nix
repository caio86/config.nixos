{ pkgs, ... }:

let
  myAliases = {
    c = "clear";
    # vim = "nvim";
    ls = "eza --icons -hl -T -L=1 --sort=type";
    ll = "eza -lh";
    # lsa = "eza -lah";
    l = "eza -lAh";
    rg = "rg --smart-case";
    cat = "bat -p";
    duh = "sudo du -h --one-file-system --max-depth=1 --threshold=100k";
    dfh = "df -h -x tmpfs -x devtmpfs";
    fzfd = ''
      escolhido=$(fd -t d | fzf)
      if [ -z "$escolhido" ]; then
        return 0
      fi

      cd $escolhido
    '';
  };
in

{
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
}
