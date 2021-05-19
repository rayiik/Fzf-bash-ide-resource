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
#        AUTHOR: Rayiik (), dsimon_aas@hotmail.com
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
_fzfrefresh () {
    for i in $(seq 1000);
do
    (( i  % 200 == 0 ));
    echo "$i"
    sleep 0.01
    done
}
fd -u . | fzf --preview="_fzfrefresh"
