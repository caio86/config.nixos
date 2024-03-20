{ userSettings, pkgs, ... }:
{
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;

  users.users.${userSettings.username}.extraGroups = [ "wireshark" ];
}
