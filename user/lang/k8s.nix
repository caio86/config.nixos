{ pkgs, ... }:

let
  gdk = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
    gke-gcloud-auth-plugin
  ]);
in
{
  home.packages = with pkgs; [
    kind
    kompose
    kubectl
    kubernetes-helm
    kustomize
    # gdk
  ];

  programs.k9s = {
    enable = true;
    # skins = { };
  };
}
