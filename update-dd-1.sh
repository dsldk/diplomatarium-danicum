#!/bin/bash -
# updateTekstnet: a utility for updating Diplomatarium Danicum texts on Tekstnet
# Original Author & date: Thomas Hansen 2023-09-05
# Project: https://github.com/dsldk/diplomatarium-danicum
# Usage?  (Better to have `-h` and/or `--help` options!)

#PROGRAM=${0##*/}  # bash version of `basename`
CURRENT_DIR=$(pwd)
SCRATCHDIR=$(mktemp -d -p "$CURRENT_DIR")

# configuration

stylesheet='/home/th/Development/tirsdag-text-factory/xsl/dipdan.xsl'
deploy_path='/home/th/Development/tirsdagsprojektet/content/books/dipdan/'
notes_destination='/home/th/Development/tirsdagsprojektet/data/notes/'

# main

while IFS= read -r dir
do

  dirname="${dir##*/}"                    # get directory name
  destination="$SCRATCHDIR"/"$dirname"    # concatenate scratch and dirname
  
  echo Transforming letters in "$dir"

  if [ ! -d "$destination" ]; then
      mkdir -p "$destination"
  fi
  
  # use Saxon XSLT processor to transform the directory contents

  java -cp /usr/local/lib/saxon/saxon9he.jar net.sf.saxon.Transform \
        -s:"$dir" \
        -xsl:"$stylesheet" \
        -o:"$destination"

  # change file extension from .xml to .html

  rename 's/.xml/.html/' "$destination"/*.xml

  # move html files in place at Tekstnet

  deploy_dir="$deploy_path""$dirname"

  if [ ! -d "$deploy_dir" ]; then
        mkdir -p "$deploy_dir"
  fi

  cp "$destination"/*.html "$deploy_dir"

done <  <(find dd-1 -name "[0-1]*" -type d)

# update notes

cp notes/*.toml "$notes_destination"

# remove temporary directory

rm -r "$SCRATCHDIR"

