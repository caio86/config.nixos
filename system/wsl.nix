{ config, lib, pkgs, nixos-wsl, ... }:

{
  imports = [
    # include NixOS-WSL modules
    # <nixos-wsl/modules>
    nixos-wsl.nixosModules.wsl
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  
  system.stateVersion = "23.11"; # Did you read the comment?
}
