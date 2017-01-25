#!/usr/bin/env bash

rm alternating_layouts.py i3.py goto mark nextfind.py nextmatch.py unmark winmenu.py

wget https://raw.githubusercontent.com/olemartinorg/i3-alternating-layout/master/alternating_layouts.py
wget https://raw.githubusercontent.com/ziberna/i3-py/master/i3.py
wget https://raw.githubusercontent.com/MicahChambers/i3-wm-scripts/master/goto
wget https://raw.githubusercontent.com/MicahChambers/i3-wm-scripts/master/mark
wget https://raw.githubusercontent.com/MicahChambers/i3-wm-scripts/master/unmark
wget https://raw.githubusercontent.com/MicahChambers/i3-wm-scripts/master/nextfind.py
wget https://raw.githubusercontent.com/MicahChambers/i3-wm-scripts/master/nextmatch.py
wget https://raw.githubusercontent.com/ziberna/i3-py/master/examples/winmenu.py
wget https://raw.githubusercontent.com/cornerman/i3-completion/master/i3_completion.sh -O /usr/share/bash-completion/completions/i3-msg

chmod 755 alternating_layouts.py goto mark nextfind.py nextmatch.py unmark winmenu.py
