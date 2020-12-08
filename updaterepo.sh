#!/bin/bash - 
#===============================================================================
#
#          FILE: updaterepo.sh
# 
#         USAGE: ./updaterepo.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Rayiik (), dsimon_aas@hotmail.com
#  ORGANIZATION: 
#       CREATED: 12/08/2020 09:48:31 AM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
while read line;
do
    git add "$line"
done <<<"$(fd -u . | estrip)"
git commit

