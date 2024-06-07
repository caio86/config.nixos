{ pkgs, ... }:

{
  # usefull CLI apps
  home.packages = with pkgs; [
    neofetch # System info
    starfetch # Random stars info
    lolcat
    cowsay
    # cava # Visualize audio in terminal
    killall # kill process by name
    bat
    eza
    fd
    bottom
    ripgrep
    tree
    tldr
    zip
    unzip
    ranger # file manager
    w3m # Text pased web browser
    jq
    vim
    lazygit
    cava
    (pkgs.callPackage ../pkgs/tmux-sessionizer.nix { })
    (pkgs.callPackage ../pkgs/tmux-navigator.nix { })
    (pkgs.callPackage ../pkgs/tmux-cht.sh.nix { })
    (pkgs.callPackage ../pkgs/tmux-windowizer.nix { })
  ];
}
