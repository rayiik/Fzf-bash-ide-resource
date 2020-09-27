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
# alt-e fzf command
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
  _varset
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

_fzcom () {
_varset
  fzf  \
      --ansi --phony \
      --preview="{ cnat; echo $_rlvar '{+}' 2>/dev/null ; fline ; \
      moreman $_tvar 2>/dev/null | \
      rg  --no-filename \
      -C 4  --no-line-number \
      -e '{}' 2>/dev/null; } " \
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
  --bind="f9:preview:'cnat; moreman {} | rg {q} -C4 --no-filename \
  --passthrur'+refresh-preview" \
  --phony
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
#
_varset () {
_tvar="$( awk -F ' ' '{print $NF}' <<<"$READLINE_LINE")"
_rlvar="$READLINE_LINE"
export _rlvar
export _tvar
}

rgt () {
 rg --ignore-case \
  --color=ansi \
  --no-filename \
  --only-matching \
  -e '-[-a-zA-Z0-9]*'
}
#
################################################################################
# this function pulls removes any word not starting with -
#
_fztrim() {
  _varset
  echo "$_tvar" \
  | xargs -r moreman \
  | rg --ignore-case \
  --color=ansi \
  --no-filename \
  --only-matching \
  -e '-[-a-zA-Z0-9]*' | \
  sort -u
}
# -e '\s-[A-Z a-z].' \
#
################################################################################
#
#
run-help () {
_varset "$@"
_choice=$(rh_com "$_rlvar")
READLINE_LINE="$READLINE_LINE ${_choice#*$'\t'}"
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
#
rh_com () {
  _varset
  _parse_help "$_tvar" | _fzcom
}
#
################################################################################
# unused for now
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
#
__coms_select__() {
  local FZF_DEFAULT_OPTS
  local cmd="command __com1"
  eval "$cmd" | \
    sort -u | \
        FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind='f4:execute({} --help; {}
          | up)' --height 100% \
    --reverse " "$(__fzfcmd)" \
    -m "$@" --preview="cnat; moreman {} | rg -e '-[-a-zA-Z0-9]*\s' \
      -e [A-Z][A-Z].*\s \
      --passthru --no-filename" |\
  while read -r item; do
    printf '%q ' "$item"
  done
  echo
}
#
################################################################################
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
#
cmmd () {
 _varset
	"_coms_" | \
		awk '{print $1}' | \
		sort -u | \
    rg --no-filename "$_tvar"
		}
#
################################################################################
#
  _flgswap () {
    if [[ "$_flag_" == ' phony' ]]; then
      _flag_="sync"; elif
  [[ "$_flag_" ==  'phony' ]]; then
      _flag_='phony'
    fi
    export _flag_
    cmmd
  }
#
################################################################################
# alt o c fzf commnad
#
__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:100%}}
      --preview='cnat; moreman {}' -- " || echo "fzf"
}
#
#################################################################################
#
_cmf (){
  _varset
fzf \
  --ansi \
  --preview-window=right:65:wrap \
  --height=85% \
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
  --bind="f8:preview(moreman $_tvar | rgt)" \
  --bind="f9:preview:'man $_tvar | rg {}'"\
	--bind="ctrl-h:execute(moreman $_tvar)" \
  --layout=default \
	--preview="cnat; moreman {} | rg --no-filename --passthru -e '-[a-zA-Z0-9]*'" \
  --bind='alt-r:reload(_flgswap)' \
  --phony
}
#
################################################################################
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
#
_fini () {
  _varset
local _tvar
cmmd | _cmf
}

################################################################################
#
fzf-coms-widget() {
  local selected="$(__coms_select__)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}
#
################################################################################
#
fini__ () {
_varset
_choice=$(_fini "$_rlvar")
READLINE_LINE="$ $(echo -E "${_choice#*$'\s'}")"
if [[ -n "$READLINE_LINE" ]]; then
  echo -E "$READLINE_LINE"; else
   READLINE_POINT=0x7fffffff
fi
fcomclean
}
#
################################################################################
#
#
_varset "$READLINE_LINE"
echo "$_tvar"
bind -m vi-insert -x '"\ee":fini__'
bind -m emacs -x '"\ee":fini__'
#
################################################################################
#
bind -m vi-insert -x '"\eo":run-help'
bind -m emacs -x '"\eo":run-help'
#
################################################################################
#
zsh-help() {
help "$READLINE_LINE" 2>/dev/null || moreman "$READLINE_LINE"; }
bind -m vi-insert -x '"\e\C-h": zsh-help'
bind -m emacs -x     '"\e\C-h": zsh-help'

################################################################################
# cusomt CTRL-E - paste from cmd function
#
  bind -m emacs-standard -x '"\C-e": fzf-coms-widget '
  bind -m vi-command -x '"\C-e": fzf-coms-widget '
  bind -m vi-insert -x '"\C-e": fzf-coms-widget '
