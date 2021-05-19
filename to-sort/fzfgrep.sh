#!/bin/bash -
#===============================================================================
#
#          FILE: fzfgrep.sh
#
#         USAGE: ./fzfgrep.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Rayiik (), dsimon_aas@hotmail.com
#  ORGANIZATION:
#       CREATED: 01/10/2021 07:58:40 AM
#      REVISION:  ---
#===============================================================================
#fd -uu -t f -d 3 | fzf --preview='cat {}' --bind='alt-q:toggle-search+unix-line-discard' \
#--bind="ctrl-alt-r:select-all+reload:rg {q} <{+} --files-with-matches"
#include "$HOME"/fzfarray.sh
_fzf_level="$(fd -uu -t f -d 3)"
fd -uu -t f -d 3 | fzf --preview="cat {}" \
    --bind='alt-q:toggle-search+unix-line-discard' \
    --bind="ctrl-b:reload:fd -uu -t f -d 3" \
    --bind="ctrl-alt-g:toggle-all+execute-silent(export _fzf_level1+=( {q} ))+reload:rg -e {q} \
    --files-with-matches <{+}" \
    --bind="alt-1:reload:"$(echo ${_fzf_level})"
    --bind="alt-2:reload:"
    --bind="alt-3:reload:
    --bind="alt-4:reload:
