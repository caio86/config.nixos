{ pkgs, ... }:

{
  default = pkgs.mkShell { packages = with pkgs; [ nixfmt-rfc-style ]; };
}
