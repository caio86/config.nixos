#! /usr/bin/env bash

if [[ $# -gt 0 ]]; then
	SCRIPT_DIR=$1
else
	SCRIPT_DIR=~/.dotfiles
fi

git clone https://github.com/caio86/config.nixos $SCRIPT_DIR

sed -i "0,/caiol/s//$(whoami)/" $SCRIPT_DIR/flake.nix
sed -i "0,/Caio Luiz/s//$(getent passwd $(whoami) | cut -d ':' -f 5 | cut -d ',' -f 1)/" $SCRIPT_DIR/flake.nix

# Open editor to manually edit flake.nix
if [[ -z "$EDITOR" ]]; then
	EDITOR=nano
fi

$EDITOR ./flake.nix
