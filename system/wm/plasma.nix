{ ... }:

{
  imports = [
    ./pipewire.nix
    ./dbus.nix
    ./fonts.nix
  ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "br";
      variant = "";
      options = "caps:escape";
    };
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";
}
