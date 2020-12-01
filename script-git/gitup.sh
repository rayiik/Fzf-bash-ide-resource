#!/bin/bash -
#===============================================================================
#
#          FILE: gitup.sh
#
#         USAGE: ./gitup.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Rayiik (), dsimon_aas@hotmail.com
#  ORGANIZATION:
#       CREATED: 10/27/2020 05:27:53 PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

for file in $(estrip <<<"$(fd -u -t f)");
        do
            git add "$file"
        done
git commit -m 'updating repo'
git push

