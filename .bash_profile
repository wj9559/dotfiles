#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && source ~/.bashrc

PATH=$PATH:~/bin
PATH=$PATH:~/bin/alias
export PATH

#[[ ! $TERM =~ screen ]] && SHELL=tmux fbterm
#[[ ! $TERM =~ screen && $XDG_VTNR -lt 6 && -z $SSH_CLIENT ]] && exec fbterm -- tmux
[[ ! $TERM =~ screen && $XDG_VTNR -lt 6 && -z $SSH_CLIENT ]] && exec tmux
[[ -z $DISPLAY && $XDG_VTNR -eq 7 ]] && exec startx ~/.xinitrc
