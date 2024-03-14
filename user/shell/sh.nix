{ pkgs, ... }:

let
  myAliases = {
    c = "clear";
    ls = "eza --icons -hl -T -L=1 --sort=type";
    lsa = "eza --icons -hlA -T -L=1 --sort=type";
    l = "eza -h --sort=type";
    la = "eza -hA --sort=type";
    ll = "eza -lh --sort=type";
    rg = "rg --smart-case";
    cat = "bat -p";
    gitfetch = "onefetch";
    lazyvim = "NVIM_APPNAME=lazyvim nvim";
    duh = "sudo du -h --one-file-system --max-depth=1 --threshold=100k";
    dfh = "df -h -x tmpfs -x devtmpfs";
    fzfd = ''
      escolhido=$(fd -t d | fzf)
      if [ -z "$escolhido" ]; then
        return 0
      fi

      cd $escolhido
    '';
    nixos-rebuild = "systemd-run --no-ask-password --uid=0 --system --scope -p MemoryLimit=16000M -p CPUQuota=60% nixos-rebuild";
    home-manager = "systemd-run --no-ask-password --uid=1000 --user --scope -p MemoryLimit=16000M -p CPUQuota=60% home-manager";
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
      theme = "robbyrussell";
      plugins = [
       "git"
       "git-auto-fetch"
       "command-not-found"
       "sudo"
       "aliases"
      ];
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
  };

  home.packages = with pkgs; [
    disfetch lolcat cowsay onefetch
    bat eza bottom fd
    direnv nix-direnv
  ];

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;
}
