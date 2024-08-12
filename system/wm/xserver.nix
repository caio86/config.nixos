{ ... }:

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
}
