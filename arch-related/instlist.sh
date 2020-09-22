#!/home/rayiik/local/bin/bash
pacman -Qlk | awk '{print $1}' | sed -e 's/.*=/\\033[/' -e
's/\[[0-9].*$/&m\\\]/' | sed -e 's/\\\\/\\/' -e 's/\[/\[\\/' >> list
