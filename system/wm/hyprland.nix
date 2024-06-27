{ pkgs, ... }:

{
  # Import wayland config
  imports = [
    ./wayland.nix
  ];

  # Security
  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
    # pam.services.login.enableGnomeKeyring = true;
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };
}

