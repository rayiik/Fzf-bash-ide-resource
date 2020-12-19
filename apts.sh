#!/bin/bash
declare choice
for choice in $(sudo apt search "$@"  | rg '/' | sed '/installed/d' | awk -F/ '{print $1}' \
   | fzf --preview='apt show {}');
    do
sudo apt-get install "$choice" || exit 1
done
