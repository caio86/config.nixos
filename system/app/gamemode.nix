{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.gamemode pkgs.mangohud ];
  programs.gamemode.enable = true;
}
