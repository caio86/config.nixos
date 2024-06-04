{ config, pkgs, ... }:

{
  imports = [
    ./pipewire.nix
    ./dbus.nix
    ./fonts.nix
  ];

  environment.systemPackages = with pkgs;
    [
      wayland
      waydroid
      (sddm-chili-theme.override {
        themeConfig = {
          background = config.stylix.image;
        };
      })
      (where-is-my-sddm-theme.override {
        themeConfig.General = {
          background = config.stylix.image;
        };
      })
    ];

  # Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "br";
      variant = "";
      options = "caps:escape";
    };
  };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    theme = "chili";
    package = pkgs.sddm;
  };


  # Configure console keymap
  console.keyMap = "br-abnt2";
}

