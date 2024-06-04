{ pkgs, userSettings, ... }:

{
  environment.systemPackages = with pkgs; [ distrobox ];

  # Virt-manager
  programs.virt-manager.enable = true;
  users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
    qemu.runAsRoot = false;
  };
}
