{ pkgs, ... }:

{
  home.packages = with pkgs; [
    jdk17
    maven
  ];
}
