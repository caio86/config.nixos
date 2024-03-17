{ pkgs, ... }:

{
  # usefull CLI apps
  home.packages = with pkgs; [
    neofetch # System info
    starfetch # Random stars info
    lolcat cowsay
    cava # Visualize audio in terminal
    killall # kill process by name
    bat eza fd bottom ripgrep
    zip unzip
    tmux
    w3m
    vim neovim
  ];
}
