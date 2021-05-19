#!/bin/bash -
#===============================================================================
#
#          FILE: fzfarray.sh
#
#         USAGE: ./fzfarray.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Rayiik (), dsimon_aas@hotmail.com
#  ORGANIZATION:
#       CREATED: 01/10/2021 11:12:25 AM
#      REVISION:  ---
#===============================================================================
set -o nounset                              # Treat unset variables as an error
declare -a _current_array
set_array() {
    sync -d "$HOJE"/array.tmp
    while IFS= read -r line;
    do
        _current_array+=( "$line" )
    done <"$HOME"/array.tmp
}
set_array
export _current_array
