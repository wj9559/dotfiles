#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && source ~/.bashrc

PATH=$PATH:~/bin
PATH=$PATH:~/bin/chromapp
PATH=$PATH:~/script
export PATH

#[[ ! $TERM =~ screen ]] && SHELL=tmux fbterm
#[[ ! $TERM =~ screen && $XDG_VTNR -lt 6 && -z $SSH_CLIENT ]] && exec fbterm -- tmux
[[ ! $TERM =~ screen && $XDG_VTNR -lt 6 && -z $SSH_CLIENT ]] && exec tmux
[[ -z $DISPLAY && $(tty) == /dev/tty7 && $EUID -ne 0 ]] && exec startx ~/.xinitrc
