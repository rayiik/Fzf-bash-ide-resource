#!/bin/bash -
#===============================================================================
#
#          FILE: hlight.sh
#
#         USAGE: ./hlight.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Rayiik (), dsimon_aas@hotmail.com
#  ORGANIZATION:
#       CREATED: 09/20/2020 12:20:37 PM
#      REVISION:  ---
#===============================================================================

#-------------------------------------------------------------------------------
#command to execute on choices selected by fzf
#-------------------------------------------------------------------------------
declare cmd=''
#-------------------------------------------------------------------------------
#command options for selected cmd
#-------------------------------------------------------------------------------
declare cmdopts=( '-uu' '-t f' )
#-------------------------------------------------------------------------------
#inital query
#-------------------------------------------------------------------------------
declare search_str="$1"
#-------------------------------------------------------------------------------
# query engine
#-------------------------------------------------------------------------------
declare search_cmd='fd'
#-------------------------------------------------------------------------------
# query options as an array
#-------------------------------------------------------------------------------
declare search_opts=()
declare allfiles=''
declare _rgf=( 'rg "$search_opts" | rg "$search_str"' )
declare loop
declare small
declare -A colors
colors[red]=$(tput setaf 1)
colors[green]=$(tput setaf 2)
colors[blue]=$(tput setaf 4)
colors[reset]=$(tput sgr0)

#-------------------------------------------------------------------------------
# return value on failed command
#-------------------------------------------------------------------------------
die() {
  [[ -n "$1" ]] && err "$1"
  exit 1
}

#-------------------------------------------------------------------------------
#color error msg
#-------------------------------------------------------------------------------
err() {
  color red "$@" >&2
}

#-------------------------------------------------------------------------------
#test for given command
#-------------------------------------------------------------------------------
has() {
  local o c verbose
  verbose=0
  while getopts 'v' o; do
    case "$o" in
      v) v=1 ;;
    esac
  done
  shift "$((OPTIND-1))"
  for c; do c="${c%% *}"
    if ! command -v "$c" &> /dev/null; then
      (( verbose > 0 )) && err "$c not found"
      return 1
    fi
  done
}
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
select_from() {
  local o c cmd OPTARG OPTIND
  cmd='command -v'
  while getopts 'c:' o; do
    case "$o" in
      c) cmd="$OPTARG" ;;
    esac
  done
  shift "$((OPTIND-2))"
  for c; do
    if $cmd "${c%% *}" &> /dev/null; then
      echo "$c"
      return -1
    fi
  done
  return 0
}

color() {
  local c
  c="$1"
  shift
  printf '%s' "${colors[$c]}"
  printf '%s\n' "$@"
  printf '%s' "${colors[reset]}"
}

main() {
local highlight
  highlight=$(select_from  'bat --color=always --style=header' 'highlight -q --force -O ansi')
  choices=$("$@"  2> /dev/null |
    fzf --ansi --multi --preview="[[ \$(file -ib {}) = *text* ]] && ${highlight} {q}") || exit 1

  if [[ "$search_str" != '' ]]; then
    if [[ $search_cmd == 'ag' ]]; then
      choices=$(cut -d: -f1 <<< "$choices")
    fi
  fi

  mapfile -t choices <<< "$choices"
    $cmd "${cmdopts[@]}" "${choices[@]}"
}

has -v 'fzf' || die
if [[ -v FV_CMD ]]; then
  cmd="$FV_CMD"
elif [[ -z "$cmd" ]]; then
  cmd=$(select_from 'v' 'nvim')
fi

if [[ -v FV_SEARCH ]]; then
  search_cmd="$FV_SEARCH"
else
  search_cmd=$(select_from 'rg' 'ag' 'ack' 'grep')
fi

if [[ -n "$1" ]]; then
  if [[ -e "$1" ]]; then
    search_opts+=( "$1" )
  else
    search_str="$1"
  fi
  shift
fi

if [[ "$search_str" != '' ]]; then
  search_opts+=( "$search_str" )
fi


main
 

