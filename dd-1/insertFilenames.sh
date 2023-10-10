#!/bin/bash -

# usage: ./insertFilenames.sh <dirname>

frompath='/home/th/Development/dipdandig/tools/insert-facs-ref'

while IFS= read -r dir
do
  for f in "$dir"/*.xml; do
    if grep -q '/.webp' "$f"; then
      id="${f%.xml}"
      id="${id#*/}"
      id="${id:2}"
      #echo "ID: $id"
      #echo "Editing file $f"
      wrongpath=$(xmlstarlet sel -N tei="http://www.tei-c.org/ns/1.0" \
        -t -v  "//tei:additional//tei:ref/@target[contains(., '/.webp')]" -n "$f")
      filefrom="${wrongpath%/.webp}"
      filefrom="${filefrom:4}"
      filefrom="${filefrom/-/_}"
      facsvalue="$(xmlstarlet sel -N tei="http://www.tei-c.org/ns/1.0" \
        -t -v "//tei:body/tei:div[@xml:id='$id']/@facs" "$frompath/$filefrom"_drb_scan.xml)"
      filefrom="${filefrom/_/-}"
      xmlstarlet ed --inplace -N tei="http://www.tei-c.org/ns/1.0" \
        -u "//tei:additional//tei:ref[@target='drb_$filefrom/.webp']/@target" \
        -v "drb_$filefrom/$facsvalue.webp" "$f"
      #echo "$facsvalue"
    fi
  done
done <  <(find "$@" -maxdepth 0 -type d)
