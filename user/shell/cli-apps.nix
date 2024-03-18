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
    tree tldr
    zip unzip
    ranger # file manager
    w3m # Text pased web browser
    vim
  ];
}
