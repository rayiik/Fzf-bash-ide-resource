#!/bin/bash -
#===============================================================================
#
#          FILE: flasher.sh
#
#         USAGE: ./flasher.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Rayiik (), dsimon_aas@hotmail.com
#  ORGANIZATION:
#       CREATED: 09/02/2020 06:56:52 PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

flasher () { while true; do printf \\e[?5h; sleep 0.1; \
 printf \\e[?5l; read -s -n1 -t1 && break; \
done;
}

