{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb = {
      layout = "br";
      variant = "";
      options = "caps:escape";
    };
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  environment.systemPackages = with pkgs; [
    xsel
  ];
}
