#!/usr/bin/env bash

sed -i "0,/teste/s//$(whoami)/" ./flake.nix
sed -i "0,/teste/s//$(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)/" ./flake.nix

# Open editor to manually edit flake.nix
if [ -z "$EDITOR" ]; then
  EDITOR=nano;
fi
$EDITOR ./flake.nix
