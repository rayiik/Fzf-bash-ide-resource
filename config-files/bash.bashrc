#!/usr/bin/bash
#-------------------------------------------------------------------------------
###  bash.bashrc
#-------------------------------------------------------------------------------

echo "this is etcbashrc"


#-------------------------------------------------------------------------------
# set mask and font
#-------------------------------------------------------------------------------
set -o vi
umask 022
setfont ter-v28b
#-------------------------------------------------------------------------------
# set term if not gui not loaded
#-------------------------------------------------------------------------------
if [[ -z "$DISPLAY"  ]]; then
    export TERM=xterm-256color; else
    export TERM=xterm-256color
fi
#-------------------------------------------------------------------------------
# sets color fuctions for PS1 and later scripts
#-------------------------------------------------------------------------------


col0="$(tput bold ; tput setaf 0)"
col1="$(tput bold ; tput setaf 1)"
col2="$(tput bold ; tput setaf 2)"
col3="$(tput bold ; tput setaf 3)"
col4="$(tput bold ; tput setaf 4)"
col5="$(tput bold ; tput setaf 5)"
col6="$(tput bold ; tput setaf 6)"
col7="$(tput bold ; tput setaf 7)"
col8="$(tput bold ; tput setaf 8)"
col9="$(tput bold ; tput setaf 9)"
col10="$(tput bold; tput setaf 10)"
col11="$(tput bold; tput setaf 11)"
col12="$(tput bold; tput setaf 12)"
col13="$(tput bold; tput setaf 13)"
col14="$(tput bold; tput setaf 14)"
col15="$(tput bold; tput setaf 15)"
colwarn="$(tput smso; tput smul)"
nc="$(tput sgr0)"
PROMPT_COMMAND="_ete1"
export termguicolors
export colorterm="tmux-256color-neovim"
_exitstatus () {
  if [[ "$?" == 0 ]];
   then
    echo -e "$col8 [$?]";
else
  echo -e "$colwarn ERROR=[$?]"
fi
}
_ete1 () {
  if [[ "$?" == 0 ]];
   then
     estat="$(_exitstatus)"
  else
    estat="$(_exitstatus)"
  fi
}
"$
if [[ "$USER" == 'rayiik' ]]; then
PS1="\[$col9\]R\[$col11\]A\[$col13\]Y\[$col1\]I\[$col2\]I\[$col8\]K:\[$col12\]\$(date +%d)\[$col13\]-\$(date +%A)-\[$col14\]\$(date +%B)\]
\[$col2\]:\[$col3\][\@]\[$col4\]<\w>\[$col5\]/\n\[$col6\]:\[$col7\]-->\[$nc\]\${estat}\[$nc\]"
fi

if [[ "$USER" != 'rayiik' ]]; then
    PS1="\[$col3\] $USER\[$col2\]\[$col11\]$(date +%d %A %B)
\[$col2\]:\[$col3\][\@]\[$col4\]<\w>\[$col5\]/\n\[$col6\]:\[$col7\]-->\[$nc\]"
fi
  export PS1
#-------------------------------------------------------------------------------
#
#-------------------------------------------------------------------------------
if [[ "$DESKTOP_SESSION" != 'plasma' ]]; then
    echo -en "\e]P0000003"  # black {background}
    echo -en "\e]P80fff2f"  #grey
    echo -en "\e]P1aa00aa"  #
    echo -en "\e]P9ff00dc"  #
    echo -en "\e]P2ff1f10"  #
    echo -en "\e]PaFF3f00"  #
    echo -en "\e]P3208f6f"  #
    echo -en "\e]Pb009a4e"  #
    echo -en "\e]P4ff00d7"  #
    echo -en "\e]Pc7f2fff"  #
    echo -en "\e]P50f980f"  #
    echo -en "\e]Pd00FF00"  #
    echo -en "\e]P600ff5f"  #
    echo -en "\e]Pe37f09f"  #
    echo -en "\e]P701879f"  #
    echo -en "\e]Pf02afaf"  # white {font color}
    #clear #for background artifacting;
fi
tput init

#-------------------------------------------------------------------------------
#exports
#-------------------------------------------------------------------------------

source  "$HOME/coms/scripts/fidt"
export INPUTRC="$HOME/.inputrc"
export TMP="$HOME/tmp"
export PAGER='nvimpager'
export MANPAGER='nvimpager'
export XAUTHORITY="$HOME/.Xauthority"
export HISTSIZE="10000000000"
export HISTFILE="$HOME/.bash_history"
export HISTCONTROL="ignoredups:ignorespaces:erasedups"
export SYSTEMD_PAGER='nvimpager'
export HISTIGNORE='ls:ps:history:cd:exit'
export LD_PRELOAD=""

#######if there are conflicting color issues between tui and gui use this flag
#if [[ -n "$DISPLAY" ]]; then
#export FCEDIT="nvim-qt" \
#export VISUAL="nvim-qt" \
#export EDITOR="nvim-qt"; else
#export FCEDIT="nvim" \
#export VISUAL="nvim" \
#export EDITOR="nvim"
#fi

export FZF_TMUX=1


#-------------------------------------------------------------------------------
## Append our default paths
#-------------------------------------------------------------------------------

export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin"

appendpath () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

##add to your path here
appendpath '/opt/cuda/bin'
appendpath '/opt/cuda/nvvmx/bin'
appendpath '/opt/cuda/samples/bin'
appendpath '/usr/bin'
appendpath '/usr/bin/core_perl'
appendpath '/usr/bin/site_perl'
appendpath '/usr/bin/vendor_perl'
appendpath '/usr/games/bin'
appendpath '/usr/local/sbin'
appendpath '/usr/opt/bin'
appendpath '/usr/share/bin'
appendpath '/usr/share/mycroft-core/bin/'
appendpath '/usr/share/owtf/venv/bin'
appendpath '/usr/share/rekall/venv/bin'
appendpath '/usr/share/ruby1.8/bin'
appendpath '/usr/share/tlsenum/venv/bin'
appendpath '/usr/share/vim/vimfiles/bin'
appendpath '/var/lib/flatpak/exports/bin'
unset appendpath


#-------------------------------------------------------------------------------
# source files
#-------------------------------------------------------------------------------
#


if test -f "$HOME/.config/user-dirs.dirs"; then
  . "$HOME/.config/user-dirs.dirs"; else
  echo "$red user-dirs.dirs not found $nc"
fi

if test -f $HOME/.config/user-dirs.locale'; then
  . $HOMEk/.config/user-dirs.locale'; else
  echo "$red user-dirs.local not found $nc"
fi


if test -f $HOME/fzf/conf/.fzf.bash; then
  . $HOME/fzf/conf/.fzf.bash; else
  echo "$red .fzf.bash not found $nc"
fi

if test -f /usr/share/bash-completion/bash_completion; then
		test -r /usr/share/bash-completion/bash_completion &&
    . /usr/share/bash-completion/bash_completion; elif
test -f "$HOME"/.local/share/bash-completion/bash_completion; then
. "$HOME"/bash-completion/bash_completion && \
echo "$red user bash completion not loaded $nc"; else
echo "$red failed to load bash-completion $nc"
fi

if  test -d /etc/profile.d; then
	for profile in /etc/profile.d/*.sh; do
		test -r "$profile" && . "$profile" && \
      echo "$blue loaded $profile"
	done
	unset profile
fi
. `which env_parallel`
if test -r "$HOME"/.bash_aliases; then
	. "$HOME"/.bash_aliases; else
  echo "$red failed to load bash_aliases $nc"
fi

 if [ -x /usr/bin/dircolors ]; then
    test -r "$HOME"/.dircolors && eval "$(dircolors -b ~/.dircolors)" ||
      eval "$(dircolors -b)"; else
    echo "$red failed to load dircolors $nc"
 fi
complete -F _complete_alias container

if test -f "$HOME"/ripgrep.conf; then
export RIPGREP_CONFIG_PATH='"$HOME"/ripgrep.conf'; else
echo "$red failed to load ripgrep.conf $nc"
fi
#-------------------------------------------------------------------------------
# functions
#-------------------------------------------------------------------------------

_psudo () {
  printf '%s' sudo\\s
}
#-------------------------------------------------------------------------------
# bindings for functions
#-------------------------------------------------------------------------------
bind -m emacs-standard '"\er": redraw-current-line'
bind -m vi-command '"\C-z": emacs-editing-mode'
bind -m vi-insert '"\C-z": emacs-editing-mode'
bind -m emacs-standard '"\C-z": vi-editing-mode'


#-------------------------------------------------------------------------------
#shell options
#-------------------------------------------------------------------------------
shopt -s autocd
#shopt -s assoc_expand_once
shopt -s cdable_vars
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s complete_fullquote
shopt -s direxpand
shopt -s dirspell
shopt -s dotglob
shopt -s expand_aliases
shopt -s extquote
shopt -s globasciiranges
shopt -s globstar
shopt -s histappend
shopt -s hostcomplete
shopt -s inherit_errexit
shopt -s interactive_comments
#shopt -s localvar_inherit
shopt -s login_shell
shopt -s no_empty_cmd_completion
shopt -s nocaseglob
shopt -s nocasematch
shopt -s progcomp
#shopt -s progcomp_alias
shopt -s promptvars
shopt -s sourcepath
shopt -s xpg_echo
set -o braceexpand
set -o functrace
set -o histexpand
set -o history
set -o interactive-comments
set -o monitor
set -o vi
clear

#-------------------------------------------------------------------------------
#shell bling this is my nametag / start up image
#-------------------------------------------------------------------------------
#cnat
#neofetch
#echo "$green testing display $nc"
#if [[ -z "$DISPLAY" ]]; then
# echo  "$cyan this is not xserver $nc"; else
#  echo "$magenta display is $DISPLAY xserver running $nc"
#fi

# mycroftboot
