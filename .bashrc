#
# ~/.bashrc
#

[[ $- != *i* ]] && return

[ -n "$DISPLAY" ] && shopt -s checkwinsize
#shopt -s no_empty_cmd_completion
shopt -s histappend
shopt -s autocd
set -o notify
#set -o vi
trap EC ERR
#[ -n "$SSH_CLIENT" ] && PS1='\n\[\e[1;34m\]\w\n\[\e[1;32m\]SSH\$\[\e[m\] ' || PS1='\n\[\e[1;34m\]\w\n\[\e[1;32m\]\$\[\e[m\] '

[ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
for file in \
~/.bash_{aliases,function,prompt,private} \
/usr/share/autojump/autojump.bash \
/usr/share/fzf/{completion,key-bindings}.bash \
/usr/share/doc/pkgfile/command-not-found.bash; do
    [ -r $file ] && source $file
done && unset file

export HISTSIZE=-10
export HISTFILESIZE=-10
export HISTTIMEFORMAT='%F_%T '
export HISTCONTROL=ignoreboth
export HISTIGNORE='pwd:l:ls:ll:cls:bash:incognitoshell:todo*:rm *\**:'

export EDITOR=vim
export VISUAL=vim
export BUILDDIR=/tmp/makepkg makepkg
[ "$TERM" == "xterm" ] && export TERM=xterm-256color
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

export phonedir=/sdcard/adbpu
export phonetermux=/data/data/com.termux/files/home/
export latestTmp=/tmp/tmp_$(whoami)/latest/
export latestScreenshot=~/Pictures/Screenshots/latest.png
export latestWallpaper=~/Pictures/Wallpaper/latest.png

complete -F _command insh doNotRepeatRun helpless
complete -a aliased
complete -F _cd cl mkcd
[ -r ~/.ssh/config ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;
