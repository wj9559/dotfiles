#!/usr/bin/env bash

BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
lncp="ln -fs"
lncp=${*:-$lncp}
mkdir ~/.config &>/dev/null

$lncp $BASEDIR/bin/ ~/
$lncp $BASEDIR/.bash_aliases ~/
$lncp $BASEDIR/.bash_aliases.temp ~/
$lncp $BASEDIR/.bash_function ~/
$lncp $BASEDIR/.bash_profile ~/
$lncp $BASEDIR/.bashrc ~/
$lncp $BASEDIR/.dircolors ~/
$lncp $BASEDIR/.fbtermrc ~/
$lncp $BASEDIR/.fonts/ ~/
$lncp $BASEDIR/.gitconfig ~/
$lncp $BASEDIR/.inputrc ~/
$lncp $BASEDIR/.moc/ ~/
$lncp $BASEDIR/.screenrc ~/
$lncp $BASEDIR/Template/ ~/
$lncp $BASEDIR/.tmux.conf ~/
$lncp $BASEDIR/.vim/ ~/
$lncp $BASEDIR/.vimrc ~/
$lncp $BASEDIR/.xinitrc ~/
$lncp $BASEDIR/.Xmodmap ~/
$lncp $BASEDIR/.xserverrc ~/
# --------------------------
$lncp $BASEDIR/dunst/ ~/.config/
$lncp $BASEDIR/fcitx ~/.config/
$lncp $BASEDIR/fontconfig/ ~/.config/
$lncp $BASEDIR/htop/ ~/.config/
$lncp $BASEDIR/i3/ ~/.config/
$lncp $BASEDIR/i3status/ ~/.config/
$lncp $BASEDIR/libfm/ ~/.config/
$lncp $BASEDIR/pcmanfm/ ~/.config/
$lncp $BASEDIR/ranger/ ~/.config/
$lncp $BASEDIR/roxterm.sourceforge.net/ ~/.config/
$lncp $BASEDIR/smplayer/ ~/.config/
$lncp $BASEDIR/systemd/ ~/.config/
$lncp $BASEDIR/zathura/ ~/.config/