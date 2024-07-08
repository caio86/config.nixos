{ pkgs, userSettings, ... }:

{
  environment.systemPackages = with pkgs; [ gns3-gui ];

  services.gns3-server.enable = true;

  users.users.${userSettings.username}.extraGroups = [ "gns3" "ubridge" ];

  services.gns3-server.vpcs.enable = true;
  services.gns3-server.ubridge.enable = true;
  services.gns3-server.dynamips.enable = true;
}
