#!/bin/bash
selected="$(fd -uu -t f log | fzf --preview="sort <{} | uniq -c | sort")"
sort <"$selected" | \
    uniq -c | \
    sort | \
    fzf
