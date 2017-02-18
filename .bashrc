#
# ~/.bashrc
#

[[ $- != *i* ]] && return

shopt -s checkwinsize
#shopt -s no_empty_cmd_completion
shopt -s histappend
shopt -s autocd
set -o notify 
#set -o vi
trap EC ERR
#PS1='\[\e[1;32m\]\u\[\e[m\]:\[\e[1;34m\]\w\[\e[m\]\$ '
[ -n "$SSH_CLIENT" ] && PS1='\[\e[1;34m\]\W\[\e[1;32m\] SSH\$\[\e[m\] ' || PS1='\[\e[1;34m\]\W\[\e[1;32m\]\$\[\e[m\] '

[[ -f ~/.dircolors ]] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
[[ -f ~/.bash_function ]] && source ~/.bash_function
[[ -f /usr/share/autojump/autojump.bash ]] && source /usr/share/autojump/autojump.bash
[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]] && source /usr/share/doc/pkgfile/command-not-found.bash

export HISTSIZE=-10
export HISTFILESIZE=-10
export HISTTIMEFORMAT='%F_%T '
export HISTCONTROL=ignoreboth
export HISTIGNORE='pwd:l:ls:ll:cls:bash:incognitoshell:todo*:'

export EDITOR=vim
export VISUAL=vim
export BUILDDIR=/tmp/makepkg makepkg
if [ "$TERM" == "xterm" ]; then
	export TERM=xterm-256color
fi
if [ -n "$DISPLAY" ]; then
    export BROWSER=chromium
else 
    export BROWSER=w3m
fi

#export http_proxy=http://10.203.0.1:5187
#export http_proxy=http://username:password@proxy.gentoo.org:8080
#export https_proxy=$http_proxy
#export ftp_proxy=$http_proxy
#export rsync_proxy=$http_proxy
#export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

export phonedir=/sdcard/9559wj/
export phonetermux=/data/data/com.termux/files/home/
