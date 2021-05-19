#!/bin/bash
# Setup fzf
# ---------
PGM="$HOME/project/Man-fzf-scripts"
export PGM
. "$PGM"/fzf/completion.bash
. "$PGM"/fzf/fzf-extra.bash
. "$PGM"/fzf/fzf.bind.bash
. "$PGM"/fzf/conf/.fzfrc
. "$PGM"/fzf/fzf-ide.bash
. "$PGM"/fzf/fzcmp
source "$PGM"/fzf/fzf-ide.bash
#export FZF_TMUX=1
echo "project fzf settup"
#!/usr/bin/env bash
#
# Define default find command or set to


