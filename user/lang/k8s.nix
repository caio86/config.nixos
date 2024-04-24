{ pkgs, ... }:

{
  home.packages = with pkgs; [
    k3d
    kompose
    kubectl
    kubernetes-helm
    kustomize
  ];

  programs.k9s = {
    enable = true;
    # skins = { };
  };
}
