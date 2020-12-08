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


while read line;
        do
            git add "$file"
        done <<<"$(fd -u . | estrip)"
git commit -a -m 'updating repo'
git push

