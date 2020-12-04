#!/bin/bash
_fixbrackets () {
nvim -c "%s/\[ /\[\[ /"  -c "%s/ ]/ ]]/" -c "%s/\[\[\[/\[\[/" -c "%s/\]\]\]/\]\]/" \
 -c "%s/\[\[\[/\[\[/" -c "%s/\]\]\]/\]\]/"  \
"${1:? #command fail}"
}

_fixbrackets "$(fd -u -t f -x rg -e ' \][[[:punct:]] \s\t]*|[[[:punct:]] \s\t]\[* ' -C1 --files-with-matches |  fzf \
--phony --preview="nvimpager {} | rg -C1 -e {q}")"
