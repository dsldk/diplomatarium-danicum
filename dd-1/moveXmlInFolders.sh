#! /bin/bash -

# Usage: ./moveXmlInFolder dipdan/

while IFS= read -r -d '' file
do
  filename=${file##*/}
  dir=${filename:3:4}
  if [ ! -d "$dir" ]; then
    mkdir $dir
  fi
  cp "$file" "$dir"
done <  <(find "$@" -type f -name '*.xml' -print0)
