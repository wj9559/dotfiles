#!/usr/bin/env bash

BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
lncp="ln -srfn"
lncp=${*:-$lncp}
mkdir ~/.config &> /dev/null

$lncp $BASEDIR/.Xmodmap ~/
$lncp $BASEDIR/.bash_aliases ~/
$lncp $BASEDIR/.bash_function ~/
$lncp $BASEDIR/.bash_profile ~/
$lncp $BASEDIR/.bash_prompt ~/
$lncp $BASEDIR/.bashrc ~/
$lncp $BASEDIR/.dircolors ~/
$lncp $BASEDIR/.fbtermrc ~/
$lncp $BASEDIR/.fonts/ ~/
$lncp $BASEDIR/.gitconfig ~/
$lncp $BASEDIR/.inputrc ~/
$lncp $BASEDIR/.ngrok ~/
$lncp $BASEDIR/.screenrc ~/
$lncp $BASEDIR/.tmux.conf ~/
$lncp $BASEDIR/.vim/ ~/
$lncp $BASEDIR/.vimrc ~/
$lncp $BASEDIR/.xinitrc ~/
$lncp $BASEDIR/.xserverrc ~/
$lncp $BASEDIR/Templates/ ~/
$lncp $BASEDIR/bin/ ~/
# --------------------------
$lncp $BASEDIR/dunst/ ~/.config/
$lncp $BASEDIR/fcitx/ ~/.config/
$lncp $BASEDIR/fontconfig/ ~/.config/
$lncp $BASEDIR/htop/ ~/.config/
$lncp $BASEDIR/i3/ ~/.config/
$lncp $BASEDIR/i3status/ ~/.config/
$lncp $BASEDIR/libfm/ ~/.config/
$lncp $BASEDIR/mpd/ ~/.config/
$lncp $BASEDIR/mpv/ ~/.config/
$lncp $BASEDIR/ncmpcpp/ ~/.config/
$lncp $BASEDIR/pcmanfm/ ~/.config/
$lncp $BASEDIR/psd/ ~/.config/
$lncp $BASEDIR/ranger/ ~/.config/
$lncp $BASEDIR/roxterm.sourceforge.net/ ~/.config/
$lncp $BASEDIR/smplayer/ ~/.config/
$lncp $BASEDIR/systemd/ ~/.config/
$lncp $BASEDIR/zathura/ ~/.config/
