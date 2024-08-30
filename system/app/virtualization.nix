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

  # Virtual Box
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableKvm = true;
  virtualisation.virtualbox.host.enableHardening = false;
  virtualisation.virtualbox.host.addNetworkInterface = false;
  users.extraGroups.vboxusers.members = [ "${userSettings.username}" ];
}
