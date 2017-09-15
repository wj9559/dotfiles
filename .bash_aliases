#
# ~/.bash_aliases
#

alias sudo='sudo '
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias mkdir='mkdir --parents --verbose'
alias bc='bc -ql'
alias lsblk='lsblk -o NAME,LABEL,SIZE,TYPE,FSTYPE,MOUNTPOINT'
alias ping='ping -c 5'
alias pkgfile='pkgfile --verbose'
alias tracepath=mtr
alias espeak='&>/dev/null espeak'
#alias ln='ln -i'
#alias mv='mv -i'
#alias rm='rm -I'
#alias cp='cp -ir'
#alias startx='startx ~/.xinitrc'
#alias sed='sed --follow-symlinks'
#alias sshd='pidof /usr/bin/sshd && systemctl stop sshd || systemctl start sshd'



if ls --color ~ &>/dev/null; then
    lsColorFlag='--color=auto'
else
    lsColorFlag='-G'
    export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi
alias l='ls -F '$lsColorFlag
alias la='ls -FA '$lsColorFlag
alias ld='ls -F --group-directories-first '$lsColorFlag
alias ll='ls -FAlh '$lsColorFlag
    unset lsColorFlag

alias pacs='pacman -Ss'
alias paci='pacman -Si'
alias pacqs='yaourt -Qs'
alias paclo='pacman -Qdtq'
#alias paclf='pacman -Ql'
alias pac='sudo pacman -S'
alias pacy='sudo pacman -Sy'
alias pacu='sudo pacman -Syu'
alias pacuu='sudo pacman -Syu --noconfirm'
alias pacuc='sudo pacman -Sy --logfile /dev/null &>/dev/null; pacman -Qu'
alias pacr='sudo pacman -Rns'
alias paccc='sudo paccache -rvk 3'
alias yao='yaourt -S'
alias yaos='yaourt -Ss'
alias yaoi='yaourt -Si'
alias yaou='yaourt -Syu --aur'

alias cls='echo -ne "\033c"; tmux clear-history; echo -ne "\033c"'
alias py='python3'
alias py2='python2'
alias py3='python3'
alias du1='du --max-depth=1 --human-readable'
alias inotify='inotifywait -mrq --timefmt %F_%T --format "%T %w %e %f" -e modify,delete,create,attrib,move'
alias inotify-ao='inotifywait -mrq --timefmt %F_%T --format "%T %w %e %f" -e access,open'
alias hd='hexdump -C'
alias path='echo -e ${PATH//:/\\n}'
alias errors='journalctl --priority=0..3 --catalog -n'
alias uninterruptibleSleep='ps -eo stat,args | grep "^D\|^Z"'
alias websiteget='wget --recursive --no-parent --page-requisites --adjust-extension --convert-links --random-wait --user-agent=mozilla'
alias caffeine='xset s off'
alias trA2a='tr [:upper:] [:lower:]'
alias tra2A='tr [:lower:] [:upper:]'
alias ps1='echo -e "\e[01;31m\t `backlight`    `volume`     `acpi`    `date "+%y-%m-%d_%a %T"`\e[m"'
alias load='uptime | cut -d, -f3- | cut -d" " -f5-'
alias snapperlist='for name in `ls /etc/snapper/configs/`; do separatedLine; snapper --iso -c $name list; done'
alias chownr2l='sudo chown 1000:100'
alias histg='history | grep'
alias listen='lsof -P -i -n'
alias port='lsof -i -P -n'
alias sniff="sudo ngrep -d 'wlo1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump='sudo tcpdump -i wlo1 -n -s 0 -w - | grep -a -o -E "Host\: .*|GET \/.*"'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cdtmp='mkcd /tmp/tmp_$(whoami)/$(randomstr); ln -sfn $PWD ../latest'
alias cdtmpp='mkcd /tmp/tmp_$(whoami)/$(randomstr)'
alias cdtmpl='cd /tmp/tmp_$(whoami)/latest &>/dev/null; if [[ $? != 0 ]]; then cdtmp; fi'
alias clamscan='clamscan --recursive --infected --log ~/clamav.log'
alias gitdiff='git diff --no-index --color-words'
alias urlencode='node -e "console.log(encodeURIComponent(process.argv[1]))"'
alias urldecode='node -e "console.log(decodeURIComponent(process.argv[1]))"'
#alias urlencode='python3 -c "import sys, urllib.parse as up; print(up.quote_plus(sys.argv[1]))"'
#alias urldecode='python3 -c "import sys, urllib.parse as up; print(up.unquote_plus(sys.argv[1]))"'
alias xclipc='xclip -selection clipboard'
alias gzipt='gzip -vc >/dev/null'
alias ffprobe-show='ffprobe -v quiet -print_format json -show_format -show_streams'
alias cpprogress='rsync -avPh'
alias date0='date +%F_%H-%M-%S'
alias date1='date +%Y%m%d%H%M%S'
alias dateft='date +%F_%T'
alias hardlink-dry-run='>hardlink.$(date1).log hardlink --ignore-{mode,owner,time} --exclude=".git|node_modules|bower_components" --verbose --dry-run'
alias hardlink-max='hardlink --ignore-{mode,owner,time} --exclude=".git|node_modules|bower_components"'
alias espeak-zh='espeak -v zh'
alias vi-nowrap='vi -c "set nowrap"'
