#!/bin/bash
_fixbrackets () {
nvim -c "%s/\[ /\[\[ /g"  -c "%s/ ]/ ]]/g" -c "%s/\[\[\[/\[\[/g" -c "%s/\]\]\]/\]\]/g" \
 -c "%s/\[\[\[/\[\[/g" -c "%s/\]\]\]/\]\]/g"  \
"${@}"
}

_fixbrackets "${@:-"$(fd -u -t f -x rg -e ' \][[[:punct:]] \s\t]*|[[[:punct:]] \s\t]\[* ' -C1 --files-with-matches |  fzf \
--phony --query=']|\[' --bind="f9:execute:_fixbrackets {}" \
--preview="nvimpager {} | rg -C1 -e {q}")"}"
