
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

pacman -Sg \
    | fzf --preview='pacman -Sg {}' \
    | rargs pacman -Ss \
    | fzf --sync --preview='pacman -Si {}'
