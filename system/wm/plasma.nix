{ ... }:

{
  imports = [
    ./pipewire.nix
    ./dbus.nix
    ./fonts.nix
    ./gnome-keyring.nix
    ./xserver.nix
  ];

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
  };
}
