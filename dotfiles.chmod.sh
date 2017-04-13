#!/usr/bin/env bash

chmod 444 smplayer/smplayer.ini
chmod 444 htop/htoprc

# -----------------------------------------
# chattr
if [ $EUID -ne 0 ]; then
    echo "chattr must be root" >&2
    exit 2
fi
sudo chattr +i pcmanfm/default/pcmanfm.conf
