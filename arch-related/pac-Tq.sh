#!/bin/bash -
#===============================================================================
#
#          FILE: pac-Tq.sh
#
#         USAGE: ./pac-Tq.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Rayiik (), dsimon_aas@hotmail.com
#  ORGANIZATION:
#       CREATED: 07/22/2020 07:38:56 AM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

for command in $(sudo pacman -Qq); do
  sudo pacman -T "$command" | cat >> ~/Tq.tmp
done

