#!/bin/sh
# Executed by startx (run your window manager from here)
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export LC_CTYPE=en_US.UTF-8

if [ true ]; then
	export LANG=en_US.UTF-8
	export LANGUAGE=en_US
else
	export LANG=zh_CN.UTF-8
	export LANGUAGE=zh_CN:en_US
fi

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

cd
xset s 180 &
xset b off &
xflux -l 30.53 -g 117.11 &
~/bin/wallpaper &
fcitx-autostart &
xcompmgr &

[ -f $HOME/.Xmodmap ] && /usr/bin/xmodmap $HOME/.Xmodmap

#exec i3 -V >> ~/logs/i3/i3log-$(date +'%F-%k-%M-%S') 2>&1
#exec i3 -V -d all >> ~/logs/i3/i3log-$(date +'%F-%k-%M-%S') 2>&1
# xinit awesome
# startx ~/.xinitrc awesome

session=${1:-i3}
case $session in
	awesome           ) exec awesome;;
	i3                ) exec i3;;
	bspwm             ) exec bspwm;;
	catwm             ) exec catwm;;
	cinnamon          ) exec cinnamon-session;;
	dwm               ) exec dwm;;
	enlightenment     ) exec enlightenment_start;;
	ede               ) exec startede;;
	fluxbox           ) exec startfluxbox;;
	gnome             ) exec gnome-session;;
	gnome-classic     ) exec gnome-session --session=gnome-classic;;
	icewm             ) exec icewm-session;;
	jwm               ) exec jwm;;
	kde               ) exec startkde;;
	mate              ) exec mate-session;;
	monster|monsterwm ) exec monsterwm;;
	notion            ) exec notion;;
	openbox           ) exec openbox-session;;
	unity             ) exec unity;;
	xfce|xfce4        ) exec startxfce4;;
	xmonad            ) exec xmonad;;

	i3n               ) exec i3 -c ~/.config/i3/config-nobar;;
	i3debug           ) exec i3 -V -d all 2>> ~/.config/i3/i3log-$(date +'%F-%k-%M-%S');;
	win               ) exec virtualbox --startvm ie11win7;;
	arch              ) exec virtualbox --startvm archinbox;;
	terminal          ) exec roxterm -f;;
	*) exec $1;;
esac