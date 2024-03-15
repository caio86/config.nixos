#!/usr/bin/env bash

input="./backups"

set -x

pattern="'(.*?)'"

while IFS= read -r line; do
  # mv $HOME/$line.backups $HOME/$line
  if [[ $line =~ $pattern ]]; then
    echo "sim"
  else
    echo "não"
  fi
  # echo "mv $HOME/$line.backups $HOME/$line"
done < $input

