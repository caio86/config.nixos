#!/usr/bin/env bash

input="./backups"

# set -x

pattern="'(.*?)'"

result=($(awk -F "'" '/Existing/ {print $2}' < $input))

echo "Restaurando backups"
echo

echo "Serão restaurados ${#result[@]} aquivos"
echo

for file in ${result[@]}; do
  echo "Restaurando arquivo '${file}'"
  mv $file.backup $file
  echo
done

