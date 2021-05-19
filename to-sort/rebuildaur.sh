#!/bin/bash -
#===============================================================================
#
#          FILE:
#         USAGE:
#   DESCRIPTION:
#       OPTIONS:
#  REQUIREMENTS:
#          BUGS:
#         NOTES:
#        AUTHOR: Rayiik (), dsimon@rayiiksolutions.com
#
#  ORGANIZATION: Rayiik Solutions
#       CREATED:
#      REVISION:
#===============================================================================
#==========================================================================
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#==========================================================================
#-------------------------------------------------------------------------------
# Global Variables:
# Arguments:
# Outputs:
#-------------------------------------------------------------------------------
set -o nounset                              # Treat unset variables as an error
set pipefaill
set errexit
while read -r line;
do cd /home/rayiik/.cache/pacaur/"$line" || return;
    makepkg -si --force --sign --key dsimon@rayiiksolutions.com
    cd /home/rayiik/.cache/pacaur || exit
done <<<"$(fd -u -t d -d 1 . | estrip)"

cd /home/rayiik/.cache/rua/build || exit 7

while read -r line;
do cd /home/rayiik/.cache/rua/build/"$line" || return;
    makepkg -si --force --sign --key dsimon@rayiiksolutions.com --noconfirm
    cd /home/rayiik/.cache/rua/build || return
done <<<"$(fd -u -t d -d 1 . | estrip)"
