#!/bin/bash

for i in "$@"
do
  xmlstarlet sel -N tei="http://www.tei-c.org/ns/1.0" \
    -t -m "//tei:editor" -f -o " | " -v "normalize-space(.)" -o " | " \
    -t -m "//tei:abstract"  -v "normalize-space(tei:ab/text())" -n -n "$i"
done
