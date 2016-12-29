#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

PATH=$PATH:$HOME/bin
export PATH

#[[ ! $TERM =~ screen ]] && SHELL=tmux fbterm
[[ ! $TERM =~ screen && $XDG_VTNR -lt 6 && -z $SSH_CLIENT ]] && exec fbterm -- tmux
[[ -z $DISPLAY && $XDG_VTNR -eq 7 ]] && exec startx ~/.xinitrc
