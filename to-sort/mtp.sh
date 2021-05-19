#!/bin/bash -
#===============================================================================
#
#          FILE: mtp.sh
#
#         USAGE: ./mtp.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Rayiik (), dsimon_aas@hotmail.com
#  ORGANIZATION:
#       CREATED: 01/03/2021 09:27:05 AM
#      REVISION:  ---
#===============================================================================
_dir="${1:-"$PWD"}"
_mtp() {
    local _dir "$@"
while read line;
do
    mv "$line" /home/rayiik/project/
done <<<"$(fd -uu -t f "${_dir}" | fzf --preview="cat {}" | estrip)"
}
_mtp "$@"
unset _dir

