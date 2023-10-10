#!/bin/bash

today="$(date +%m%d)"

find xml -type f -name "[0-1][0-9][0-9][0-9]$today*" \
  -exec xmlstarlet sel \
  -N tei="http://www.tei-c.org/ns/1.0" \
  -t -m "//tei:abstract" \
  -f -o " -- " -v "normalize-space(.)" -n -n {} \;
#for f in *; do
#    [[ -e $f ]]
#    echo "$f"
#    awk -v var="$today" '$0 ~ var' "$f"
    #file=$(echo "$f" | awk -v var="$today" '$0 ~ var')
    #echo "$file"
    #xmlstarlet sel -N tei="http://www.tei-c.org/ns/1.0" -t -v "//tei:abstract//text()" xml/"$file"
#done


