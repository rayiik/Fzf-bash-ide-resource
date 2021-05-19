#!/bin/bash
PKGLOG="$HOME/pkg/makepkglog"
if [[ ! -d "$PKGLOG" ]]; then
    mkdir "$PKGLOG"
fi
while read line;
do
    mv "$line" "${PKGLOG}/"
done <<<"$(fd -u -t f "pk*" -d 2 "$TMP/" | estrip)"
cat </dev/null >"$TMP/"
rm -r "$TMP/*"
