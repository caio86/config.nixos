{ lib, pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-qt;
    enableSSHSupport = true;
  };
}
