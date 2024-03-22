#!/usr/bin/env bash

home-manager uninstall

source ./restore_backups.sh

rm -rf ~/.dotfiles/
