#!/bin/bash
#===============================================================================
#
#          FILE: test2.sh
#
#         USAGE: ./test2.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Rayiik (), dsimon_aas@hotmail.com
#  ORGANIZATION:
#       CREATED: 08/01/2020 07:31:38 PM
#      REVISION:  ---
#===============================================================================
#-------------------------------------------------------------------------------
# taken from bash completion not currently implamented as fztrim below produces
# better results (short and long options)
#-------------------------------------------------------------------------------
dequote()
{
    eval printf %s "$1" 2>/dev/null
}
quote()
{
    local quoted=${1//\'/\'\\\'\'}
    printf "'%s'" "$quoted"
}
_parse_help()
{
    eval local cmd="$(quote "$_tvar")"
    local line
    {
        case $cmd in
            -) cat ;;
            *) LC_ALL=C "$(dequote "$cmd")" ${2:---help} 2>&1 ;;
        esac
    } |
        while read -r line; do

            [[ $line == *([[:blank:]])-* ]] || continue
            # transform "-f FOO, --foo=FOO" to "-f , --foo=FOO" etc
            while [[ $line =~ \
                ((^|[^-])-[A-Za-z0-9?][[:space:]]+)\[?[A-Z0-9]+([,_-]+[A-Z0-9]+)?(\.\.+)?\]? ]]; do
                line=${line/"${BASH_REMATCH[0]}"/"${BASH_REMATCH[1]}"}
            done
            __parse_options "${line// or /, }"

        done
}
__parse_options()
{
    local option option2 i IFS=$' \t\n,/|'

    # Take first found long option, or first one (short) if not found.
    option=
    local -a array=($1)
    for i in "${array[@]}"; do
        case "$i" in
            ---*) break ;;
            --?*)
                option=$i
                break
                ;;
            -?*) [[ $option ]] || option=$i ;;
            *) break ;;
        esac
    done
    [[ $option ]] || return 0

    IFS=$' \t\n' # affects parsing of the regexps below...

    # Expand --[no]foo to --foo and --nofoo etc
    if [[ $option =~ (\[((no|dont)-?)\]). ]]; then
        option2=${option/"${BASH_REMATCH[1]}"/}
        option2=${option2%%[<{().[]*}
        printf '%s\n' "${option2/=*/=}"
        option=${option/"${BASH_REMATCH[1]}"/"${BASH_REMATCH[2]}"}
    fi

    option=${option%%[<{().[]*}
    printf '%s\n' "${option/=*/=}"
}


#
################################################################################
#
################################################################################
#
_fline () {
  printf "%"${FZF_PREVIEW_COLUMNS}"s" " "  | tr " " "-"
}
#
################################################################################
#-------------------------------------------------------------------------------
# this sets function sets our realine variable
#-------------------------------------------------------------------------------
#
_varset () {
_tvar="$(awk -F ' ' '{print $NF}' <<<"$READLINE_LINE")"
_rlvar="$READLINE_LINE"
_endline="$(awk -F ' ' '{print $1}' <<<"$READLINE_LINE")"
export _endline
export _rlvar
export _tvar
}
#-------------------------------------------------------------------------------
# this function trims out put to flags starting with -/-- but is better for
# fzf
#-------------------------------------------------------------------------------
rgt () {
rg --ignore-case \
-e '^-[-a-zA-Z0-9]*' \
-e '[ \s\t]-[-a-zA-Z0-9]*' \
-e '^-[-a-zA-Z][0-9a-z]*' \
-e '^-[a-zA-Z].' \
-e '\s-[a-zA-Z].' \
--only-matching \
--no-filename | \
sort -u | \
sed -e 's/^--$//' | \
sed -e 's/^-$//' | \
sed -e 's/,//'
}
#
################################################################################
#-------------------------------------------------------------------------------
# this function pulls removes any word not starting with -
#-------------------------------------------------------------------------------
#
_fztrim() {
 _varset
 local _trimvar
_trimvar="$_tvar"
  { moreman "$_trimvar";"$_trimvar" --help; } | \
rg --ignore-case \
-e '^-[-a-zA-Z0-9]*' \
-e '[ \s\t]-[-a-zA-Z0-9]*' \
-e '^-[-a-zA-Z][0-9a-z]*' \
-e '^-[a-zA-Z].' \
-e '\s-[a-zA-Z].' \
--only-matching \
--no-filename | \
sort -u | \
sed -e 's/^--$//' | \
sed -e 's/^-$//' | \
sed -e 's/,//'
}
#
################################################################################
#-------------------------------------------------------------------------------
# this is a main body script function that parses readline and uses commands
# from bash-completion to generate results
#-------------------------------------------------------------------------------
#
run-help () {
_varset "$@"
_choice=$(rh_com "$_rlvar")
READLINE_LINE="$READLINE_LINE $(tr '\n' ' ' <<<"${_choice#*$'\t'}")"
if [[ -n "$READLINE_LINE" ]]; then
  print '%s '"$READLINE_LINE" | \
    tr \\n \\s;
   READLINE_POINT=0x7fffffff; else
   READLINE_POINT=0x7fffffff
fi
clear
fcomclean
}
#
################################################################################
#-------------------------------------------------------------------------------
# this is a sub command of run-help that calls the completion functions
# to the fzf script
#-------------------------------------------------------------------------------

rh_com () {
#  _varset
 _fztrim "$_tvar" | _fzcom
}
#_parse-help swaps with _fztrim (still in testin)
################################################################################
#-------------------------------------------------------------------------------
# unused for now
#-------------------------------------------------------------------------------
#_fzf_args() {
#  _varset
#  local selected=$(_fini)
#  READLINE_LINE=" \
#    ${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
#  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
#  fcomclean
#}
#
################################################################################
#-------------------------------------------------------------------------------
# this command populates a list with commands from $PATH
#-------------------------------------------------------------------------------
__coms_select__() {
  local cmd="command __com1"
  eval "$cmd" | \
    sort -u | \
    $(__fzfcmd) \
    -m --preview="rgt <<<\$(moreman {})" | \
  while read -r item; do
    printf '%q ' "$item"
  done
  echo
}
#

################################################################################
#-------------------------------------------------------------------------------
#  filters commands down to just name
#-------------------------------------------------------------------------------
#
cmmd () {
	"_coms_" | \
		awk '{print $1}' | \
		sort -u | \
    rg --no-filename "$_tvar"
		}
#
################################################################################
#-------------------------------------------------------------------------------
# currently unused but will be a switch between phony fzf searching preview
# from {q} and regular searching
#-------------------------------------------------------------------------------
#  _flgswap () {
#    if [[ "$_flag_" == ' phony' ]]; then
#      _flag_="sync"; elif
#  [[ "$_flag_" ==  'phony' ]]; then
#      _flag_='phony'
#    fi
#    export _flag_
#    cmmd
#  }
#
################################################################################
#-------------------------------------------------------------------------------
# alt o c fzf commnad
#-------------------------------------------------------------------------------
#
__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:100%}}
      --preview='moreman {}' -- " || echo "fzf"
}
#
#################################################################################
#-------------------------------------------------------------------------------
#core fzf command
#-------------------------------------------------------------------------------
#
_cmf (){
fzf \
  --ansi \
  --preview-window=right:65:wrap \
  --height=100% \
  --info=default \
  --bind='ctrl-a:preview-page-up' \
  --bind='ctrl-s:preview-page-down' \
  --bind='ctrl-u:half-page-up+refresh-preview' \
  --bind='ctrl-d:half-page-down+refresh-preview' \
  --bind='alt-u:page-up+refresh-preview' \
  --bind='alt-h:backward-char+refresh-preview' \
  --bind='alt-l:forward-char+refresh-preview' \
  --bind='alt-d:page-down+refresh-preview' \
  --bind="alt-1:execute(printf {})+refresh-preview" \
  --bind="alt-2:toggle+replace-query" \
  --bind="alt-3:execute(print {q})+refresh-preview" \
  --bind="alt-h:preview(moreman $_tvar)" \
  --bind="f8:preview:moreman $_tvar | rgt" \
  --bind="f9:preview:man $_tvar | rg {}"\
	--bind="ctrl-h:execute:moreman $_tvar" \
  --layout=default \
	--preview="moreman {} | rg --no-filename --passthru -e '-[a-zA-Z0-9]*'" \
  --bind='alt-r:reload(_flgswap)'
}
#
################################################################################
#-------------------------------------------------------------------------------
#cleans variales after execution
#-------------------------------------------------------------------------------
#
fcomclean () {
unset _iniquery
unset RG_PREFIX
unset _tvar
unset _rlvar
unset dir
unset _fvar
unset _flag_
unset file
unset Fvar
unset selected
}
#
################################################################################
#-------------------------------------------------------------------------------
# calls commands and pipes them to fzf
#-------------------------------------------------------------------------------
_fini () {
cmmd | rg "$_tvar" | _cmf
}

################################################################################
#-------------------------------------------------------------------------------
# prints line after seletion
#-------------------------------------------------------------------------------
fzf-coms-widget() {
  local selected
  selected="$(__coms_select__ "$@")"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}
#
################################################################################
#-------------------------------------------------------------------------------
#another version the fzf-coms-widget
#-------------------------------------------------------------------------------
fini__ () {
_varset
_choice=$(_fini "$_rlvar")
if [[ -n "$_choice" ]];
        then
            unset READLINE_LINE;
            READLINE_POINT=$(( READLINE_POINT + ${#_choice} ))
            else
                READLINE_LINE="${_rlvar}"
                READLINE_POINT=0x7fffffff
fi
READLINE_LINE="$(echo -E "${_choice#*$' '}")"

if [[ -n "$READLINE_LINE" ]]; then
  echo -E "$READLINE_LINE" && \
  READLINIE_POINT=$(( READLINE_POINT + ${_choice} )); else
  READLINE_LINE="${_rlvar}"
   READLINE_POINT=0x7fffffff
fi
}
#
################################################################################
#-------------------------------------------------------------------------------
# not finished but populates commands based on path and on whats currently in
# readline
#-------------------------------------------------------------------------------
#
bind -m vi-insert -x '"\ee":fini__'
bind -m emacs -x '"\ee":fini__'
#
################################################################################
#-------------------------------------------------------------------------------
#Displays flags and prints them to command line but doesnt execute
#-------------------------------------------------------------------------------
#
bind -m vi-insert -x '"\eo":run-help'
bind -m emacs -x '"\eo":run-help'
#
################################################################################
#-------------------------------------------------------------------------------
# mimics the zsh help fucntion pressing ctrl h opens manpage of word under
# cursor
#-------------------------------------------------------------------------------
zsh-help() {
help "$READLINE_LINE" 2>/dev/null || moreman "$READLINE_LINE"; }
bind -m vi-insert -x '"\e\C-h": zsh-help'
bind -m emacs -x     '"\e\C-h": zsh-help'

################################################################################
#-------------------------------------------------------------------------------
# prints commands in path and prints the to command line without executing
#-------------------------------------------------------------------------------
#
  bind -m emacs-standard -x '"\C-e": fzf-coms-widget '
  bind -m vi-command -x '"\C-e": fzf-coms-widget '
  bind -m vi-insert -x '"\C-e": fzf-coms-widget '

_fzcom () {
  fzf  \
      --ansi \
      --preview="{ echo $_rlvar '{+}' 2>/dev/null; fline;  \
      tput sgr0; cat <({} --help 2>/dev/null)  <(moreman $_tvar 2>/dev/null) | \
      rg -C6  -e {} | \
      rg  --no-filename \
      -C4  --no-line-number \
      -e {+} -e {} 2>/dev/null; } " \
  --preview-window=right:65:wrap \
  --info=default \
  --bind='ctrl-a:preview-page-up' \
  --bind='ctrl-s:preview-page-down' \
  --bind='ctrl-u:half-page-up+refresh-preview' \
  --bind='ctrl-d:half-page-down+refresh-preview' \
  --bind='alt-u:page-up+refresh-preview' \
  --bind='alt-h:backward-char+refresh-preview' \
  --bind='alt-l:forward-char+refresh-preview' \
  --bind='alt-d:page-down+refresh-preview' \
  --bind="alt-1:execute(printf {})+refresh-preview" \
  --bind="alt-2:toggle+replace-query" \
  --bind="alt-3:execute(printf {q})+refresh-preview" \
  --bind="alt-h:preview(moreman $_tvar)" \
  --bind="alt-n:preview:'moreman {} | rg {q} -C4  \
          --passthru --no-filename'" \
  --no-clear \
  --bind="f9:preview:'moreman {} | rg {q} -C4 --no-filename \
  --passthrur'+refresh-preview"
}
#
################################################################################
# this function creats a line to seperate imput based on screen width
################################################################################
#
_fline () {
  printf "%"${FZF_PREVIEW_COLUMNS}"s" " "  | tr " " "-"
}

#-------------------------------------------------------------------------------
# this function trims out put to flags starting with -/-- but is better for
# fzf
#-------------------------------------------------------------------------------
rgt () {
rg --ignore-case \
-e '^-[-a-zA-Z0-9]*' \
-e '[ \s\t]-[-a-zA-Z0-9]*' \
-e '^-[-a-zA-Z][0-9a-z]*' \
-e '^-[a-zA-Z].' \
-e '\s-[a-zA-Z].' \
--only-matching \
--no-filename | \
sort -u | \
sed -e 's/^--$//' | \
sed -e 's/^-$//' | \
sed -e 's/,//'
}
#
################################################################################
#-------------------------------------------------------------------------------
# this function pulls removes any word not starting with -
#-------------------------------------------------------------------------------
#
_fztrim() {
 _varset
 local _trimvar
_trimvar="$_tvar"
  { moreman "$_trimvar";"$_trimvar" --help; } | \
rg --ignore-case \
-e '^-[-a-zA-Z0-9]*' \
-e '[ \s\t]-[-a-zA-Z0-9]*' \
-e '^-[-a-zA-Z][0-9a-z]*' \
-e '^-[a-zA-Z].' \
-e '\s-[a-zA-Z].' \
--only-matching \
--no-filename | \
sort -u | \
sed -e 's/^--$//' | \
sed -e 's/^-$//' | \
sed -e 's/,//'
}
#
################################################################################
#-------------------------------------------------------------------------------
# this is a main body script function that parses readline and uses commands
# from bash-completion to generate results
#-------------------------------------------------------------------------------
#
run-help () {
_varset "$@"
_choice=$(rh_com "$_rlvar")
READLINE_LINE="$READLINE_LINE $(tr '\n' ' ' <<<"${_choice#*$'\t'}")"
if [[ -n "$READLINE_LINE" ]]; then
  print '%s '"$READLINE_LINE" | \
    tr \\n \\s;
   READLINE_POINT=0x7fffffff; else
   READLINE_POINT=0x7fffffff
fi
clear
fcomclean
}
#
################################################################################
#-------------------------------------------------------------------------------
# this is a sub command of run-help that calls the completion functions
# to the fzf script
#-------------------------------------------------------------------------------

rh_com () {
#  _varset
 _fztrim "$_tvar" | _fzcom
}
#_parse-help swaps with _fztrim (still in testin)
################################################################################
#-------------------------------------------------------------------------------
# unused for now
#-------------------------------------------------------------------------------
#_fzf_args() {
#  _varset
#  local selected=$(_fini)
#  READLINE_LINE=" \
#    ${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
#  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
#  fcomclean
#}
#
################################################################################
#-------------------------------------------------------------------------------
# this command populates a list with commands from $PATH
#-------------------------------------------------------------------------------
__coms_select__() {
  local cmd="command __com1"
  eval "$cmd" | \
    sort -u | \
    $(__fzfcmd) \
    -m --preview="rgt <<<\$(moreman {})" | \
  while read -r item; do
    printf '%q ' "$item"
  done
  echo
}
#
################################################################################
#-------------------------------------------------------------------------------
# the core commands generator
#-------------------------------------------------------------------------------
#
_coms_ () {
case "$PATH" in
  (*[!:]:) PATH="$PATH:" ;;
esac

set -f; IFS=:
for dir in $PATH; do
  set +f
  [ -z "$dir" ] && dir="."
  for file in "$dir"/*; do
    if [ -x "$file" ] && ! [ -d "$file" ]; then
	    printf '%s = %s\n' "${file##*/}" "$file"
    fi
  done
done
}
#
################################################################################
#-------------------------------------------------------------------------------
# currently unused but will be a switch between phony fzf searching preview
# from {q} and regular searching
#-------------------------------------------------------------------------------
#  _flgswap () {
#    if [[ "$_flag_" == ' phony' ]]; then
#      _flag_="sync"; elif
#  [[ "$_flag_" ==  'phony' ]]; then
#      _flag_='phony'
#    fi
#    export _flag_
#    cmmd
#  }
##

#################################################################################
#-------------------------------------------------------------------------------
#core fzf command
#-------------------------------------------------------------------------------
#
_cmf (){
fzf \
  --ansi \
  --preview-window=right:65:wrap \
  --height=100% \
  --info=default \
  --bind='ctrl-a:preview-page-up' \
  --bind='ctrl-s:preview-page-down' \
  --bind='ctrl-u:half-page-up+refresh-preview' \
  --bind='ctrl-d:half-page-down+refresh-preview' \
  --bind='alt-u:page-up+refresh-preview' \
  --bind='alt-h:backward-char+refresh-preview' \
  --bind='alt-l:forward-char+refresh-preview' \
  --bind='alt-d:page-down+refresh-preview' \
  --bind="alt-h:preview(moreman $_tvar)" \
  --bind="ctrl-h:execute:moreman $_tvar" \
  --layout=default \
	--preview="moreman {} | rg --no-filename --passthru -e '-[a-zA-Z0-9]*'"

}
#
################################################################################
#-------------------------------------------------------------------------------
#cleans variales after execution
#-------------------------------------------------------------------------------
#
fcomclean () {
unset _iniquery
unset RG_PREFIX
unset _tvar
unset _rlvar
unset dir
unset _fvar
unset _flag_
unset file
unset Fvar
unset selected
}
#
################################################################################
#-------------------------------------------------------------------------------
# calls commands and pipes them to fzf
#-------------------------------------------------------------------------------
_fini () {
cmmd | rg "$_tvar" | _cmf
}

################################################################################
#-------------------------------------------------------------------------------
# prints line after seletion
#-------------------------------------------------------------------------------
fzf-coms-widget() {
  local selected
  selected="$(__coms_select__ "$@")"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}
#
################################################################################
#-------------------------------------------------------------------------------
#another version the fzf-coms-widget
#-------------------------------------------------------------------------------
fini__ () {
_varset
_choice=$(_fini "$_rlvar")
if [[ -n "$_choice" ]];
        then
            unset READLINE_LINE;
            READLINE_POINT=$(( READLINE_POINT + ${#_choice} ))
            else
                READLINE_LINE="${_rlvar}"
                READLINE_POINT=0x7fffffff
fi
READLINE_LINE="$(echo -E "${_choice#*$' '}")"

if [[ -n "$READLINE_LINE" ]]; then
  echo -E "$READLINE_LINE" && \
  READLINIE_POINT=$(( READLINE_POINT + ${_choice} )); else
  READLINE_LINE="${_rlvar}"
   READLINE_POINT=0x7fffffff
fi
}
#
################################################################################
#-------------------------------------------------------------------------------
# not finished but populates commands based on path and on whats currently in
# readline
#-------------------------------------------------------------------------------
#
bind -m vi-insert -x '"\ee":fini__'
bind -m emacs -x '"\ee":fini__'
#
################################################################################
#-------------------------------------------------------------------------------
#Displays flags and prints them to command line but doesnt execute
#-------------------------------------------------------------------------------
#
bind -m vi-insert -x '"\eo":run-help'
bind -m emacs -x '"\eo":run-help'
#
################################################################################
#-------------------------------------------------------------------------------
# mimics the zsh help fucntion pressing ctrl h opens manpage of word under
# cursor
#-------------------------------------------------------------------------------
zsh-help() {
help "$READLINE_LINE" 2>/dev/null || moreman "$READLINE_LINE"; }
bind -m vi-insert -x '"\e\C-h": zsh-help'
bind -m emacs -x     '"\e\C-h": zsh-help'

################################################################################
#-------------------------------------------------------------------------------
# prints commands in path and prints the to command line without executing
#-------------------------------------------------------------------------------
#
  bind -m emacs-standard -x '"\C-e": fzf-coms-widget '
  bind -m vi-command -x '"\C-e": fzf-coms-widget '
  bind -m vi-insert -x '"\C-e": fzf-coms-widget '
