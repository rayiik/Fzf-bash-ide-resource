#!/bin/bash

if [[ -n "$2" ]];
    then
        export videopath="$2";
        else
            export videopath="$HOME"
fi
if [[ -n "$1" ]];
            then
                export videoquery="$1";
            else
                export videoquery="."
fi

vidsearchcmd () {
    set -x -v
        fd -uu . --full-path "$videopath" | rg -e "$videoquery"
set +x +v
}
mainvidsearch () {
        set -x -v
local selected
selection="$(vidsearchcmd  | fzf -m)"

                if [[ -n "$selection" ]];
                        then
                (vlc "$selection" && disown -a &);
        else
return 1
fi
set +x +v
}
selectvid () {
    set -x -v
    local selected
    selected="$(vidsearchcmd "$@"  | fzf -m)"
    select file in $selected;
    do vlc "$file" && disown -a &
    done
    set +x +v
}
selectvid "$@"
#mainvidsearch "$@"
