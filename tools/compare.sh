#!/bin/bash

while read -r filename
do
    if [ -e xml/"$filename" ]
    then printf "%s\tpublished\n" "$filename"
    else printf "%s\tnot published\n" "$filename"
    fi
done < "$@"
