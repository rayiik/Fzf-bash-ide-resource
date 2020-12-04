#!/bin/bash

test [[ -d "$HOME"/projects  ]] || mkdir "$HOME"/projects -p
INSTDIR="$HOME"/projects
cd "${INSTDIR}" || exit
_coms () {
    set -f; IFS=:
for dir in $PATH; do
  set +f
  [ -z "$dir" ] && dir="."
  for file in "$dir"/*; do
    if [ -x "$file" ] && ! [ -d "$file" ]; then
	    printf '%s = %s\n' "${file##*/}" "$file"
    fi
  done
done
}
while read line;
    do
    [[ "$(_coms | rg "$line")" ]] || echo "$line" >> \ "${INSTDIR}"/deps
done <<EOF
curl
git
rg
moreman
fd
fd-find




