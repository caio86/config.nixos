#!/usr/bin/env bash

input="./backups"

# set -x

pattern="'(.*?)'"

echo $(awk -F "'" '/Existing/ {print $2}' < $input)

# while IFS= read -r line; do
#   # mv $HOME/$line.backups $HOME/$line
#   result= $(echo $line | awk -F "'" '/Existing/ {print $2}')
#   if [[ $result == " " ]]; then
#     echo "tem"
#   else
#     echo "Não tem"
#   fi
#   # echo "Output: {$result}"
#   # echo "mv $HOME/$line.backups $HOME/$line"
# done < $input

