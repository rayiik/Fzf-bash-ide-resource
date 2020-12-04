#!/usr/bin/env bash
#alias




#-------------------------------------------------------------------------------
#functions
#-------------------------------------------------------------------------------


cd () {
        local dir="$1"
        if [[ "$dir" == '-' ]];
        then dir="$OLDPWD"
        fi
        local dir="${dir:=$HOME}"
        if [[ -d "$dir" ]]; then
             builtin 'cd' "$dir" >/dev/null || return; lsd -a
        else
                echo "bash: cdls: $dir: Directory not found"
        fi
}

#             if [[ "$(ls --color=auto | wc -l)" -gt 100 ]]; then
#                        PS3="output is really long view anyways? y/n::"
#                        select chocie in y n;
#                        do
#                            if [[ "$choice" == 'y' ]];
#                            then
#                                [[ "$(ls --color=always --group-directories-first)" ]] && exit 0;
#                            elif
#                            [[ "$choice" == 'n' ]];
#                        then
#                                       echo "currently in $PWD" && exit 3
#                            fi
#                                    done
#
#                                    fi;
#
pacup () {
sudo pacman -Syyu \
    --needed --noconfirm | \
    tee -a /home/rayiik/tmp/pacup.tmp \
   || exit 1 
}

pacfunc () {

  IFS=$'\n'
  for line in $(makepkg -si | tee -a &>./pkglog 2>/dev/null 1>/dev/stdout); do
   for word in $line; do
     if [[ "$word" == 'error' ]]; then
       printf '%s' "${word//$col1 $word $nc/} 2>&1 "; elif
       [[ "$word" == 'warning' ]]; then
    printf '%s' "${word//$col8 $word $nc/} 2>&1 "; elif
        [[ "$word" == 'no' ]]; then
    "${word//$col3 $word $nc/}"; else
    printf '%s' "$word"
     fi
   done
 done
}

#-------------------------------------------------------------------------------
# conditional aliases
#-------------------------------------------------------------------------------










#-------------------------------------------------------------------------------
# aliase s
#-------------------------------------------------------------------------------

alias fdm="findmnt"
alias python='python3'
alias mkpkg='makepkg -si | tee >./pkglog | colorize'
alias rm="rm -I"
alias mv='mv -I'
alias ffox='firefox && disown -a &'
alias tbird='thunderbird && disown -a &'
echo 'this is bash aliases'
alias findmnt='findmnt '
alias gparted='sudo gparted && disown -a &'
alias cp='cp -i'
alias fd='fd --color=always'
alias pip='python3 -m pip'
alias mycs='mycroft-start'

alias info='info --vi-keys'
alias cdm='cd /home/rayiik/project/Man-fzf-scripts'
alias nr='nvidia-xrun'
alias nvp='nvimpager'
alias wcl='wl-clip'
alias wcp='wl-copy'
alias wpst='wl-paste'
alias ap3m='ap3m.sh'
alias ip='ip --color=always'
alias acr='arch-chroot'
alias diff='diff --color=always'
alias cdf='zd -f'
alias cda='_fda'
alias nvi='nvim'
alias nvmi='nvim'
alias nivm='nvim'
alias cdp='cd /home/rayiik/project/Man-fzf-scripts'
alias pwd='$PWD '
alias sudo='sudo '
alias mt='mount'
alias ..='zd ..'
alias ct='cat -s'
alias dir='dir --color=auto'
alias curl='curl --user-agent "noleak" '
alias vi='vim'
alias shred='shred -zf'
alias lsd='lsd -a'
alias vm='nvim'
alias l="\$HOME/.cargo/bin/ls -aF --color=auto"
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias cds='cd /home/rayiik/fzfscripts'
alias cdbf='cd /home/rayiik/coms/scripts/'
alias pacman-rem='sudo pacman -R --unneeded --recursive --nosave --color=always'
alias pacman-find='sudo pacman -Qiqe >> packages'
#alias ls='ls -A -F --color=always --group-directories-first'
alias append_path='appendpath'
alias lla='exa -F'
alias reflector='sudo reflector --sort rate --latest 20  --save /etc/pacman.d/mirrorlist'
alias ps1='ps -e | fzf | rg '
alias vdir='vdir --color=auto'
alias ppng='prettyping'
alias container='docker\ container'
alias nv='nvim'
alias rs='rsfetch '
alias mkdir='uu-mkdir '
alias mkfifo='uu-mkfifo '
alias mknod='uu-mknod '
alias mv='uu-mv '
alias nice='uu-nice '
alias nl='uu-nl '
alias nproc='uu-nproc '
alias nohup='uu-nohup '
alias paste='uu-paste '
alias pathchk='uu-pathchk '
alias printenv='uu-printenv '
alias pinky='uu-pinky '
alias ptx='uu-ptx '
alias printenv='uu-printenv '
alias readlink='uu-readlink '
alias realpath='realpath '
alias relpath='relpath '
alias rm='uu-rm -I'
alias rmdir='uu-rm -I '
alias seq='uu-seq '
alias shred='uu-shred '
alias shuf='uu-shuf '
alias rsc='rustscan -b 8092'
alias sleep='uu-sleep '
alias stat='uu-stat '
alias stdbuf='uu-stdbuf '
alias sum='uu-sum '
alias sync='uu-sync '
alias tac='uu-tac '
alias tee='uu-tee '
alias timeout='uu-timeout '
alias touch='uu-touch '
alias tr='uu-tr '
alias truncate='uu-truncate '
alias tsort='uu-tsort '
alias tty='uu-tty'
alias uname='uu-uname '
alias unexpand='uu-unexpand'
alias uni='uu-unique '
alias unlink='uu-unlink '
alias stx='unset DISPLAY; startxfce4'
alias users='uu-users'
alias comc='compgen -c'
alias cl='dls'
alias wc='uu-wc'
alias who="uu-who"
alias whoami='uu-whoami '
alias cargo='cargo --color=always'
alias yes='uu-yes'
alias ll='lsd -laF --color=auto'
alias di='pyls'
alias bat1='bat --color=always --theme=solarized-light'
alias pacsc='sudo pacman -Slq | fzf -m --preview pacman -Si {1} | xargs -ro sudo pacman -S'
alias comc='compgen -c'
alias ...='zd ..'
alias cd1='cd /home/rayiik/coms/scripts/; ls -a'
alias cd2='cd /home/rayiik/fzfscripts; ls -a'
alias fdl='fdisk -l '
alias sssid='sudo iw dev wlo1 scan | rg -C0 --no-filename SSID: | sort -u'
alias shf='ssh rayiik@192.168.1.225'
alias nx='unset DISPLAY; nvidia-xrun startxfce4'
alias ls='lsd --color=always'
