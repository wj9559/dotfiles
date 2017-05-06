#
# ~/.bash_aliases
#

alias sudo='sudo '
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias mkdir='mkdir -pv'
alias bc='bc -ql'
alias lsblk='lsblk -o NAME,LABEL,SIZE,TYPE,FSTYPE,MOUNTPOINT'
alias ping='ping -c 5'
alias acpi='bDir="/sys/class/power_supply/BAT0"; [ -e $bDir ] || bDir="/sys/class/power_supply/BAT1"; echo $(cat $bDir/status)\ $(cat $bDir/capacity)%; unset bDir'
alias pkgfile='pkgfile -v'
alias tracepath=mtr
alias time='/usr/bin/time'
#alias startx='startx ~/.xinitrc'
#alias sshd='pidof /usr/bin/sshd && systemctl stop sshd || systemctl start sshd'
#alias rm='rm -I'
#alias cp='cp -ir'
#alias mv='mv -i'
#alias ln='ln -i'



if ls --color ~ &>/dev/null; then
    lsColorFlag='--color=auto'
else
    lsColorFlag='-G'
    export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi
alias l='ls -F '$lsColorFlag
alias la='ls -FA '$lsColorFlag
alias ll='ls -FAlh '$lsColorFlag
    unset lsColorFlag

alias pacs='pacman -Ss'
alias paci='pacman -Si'
alias pacqs='yaourt -Qs'
alias paclo='pacman -Qdtq'
alias paclf='pacman -Ql'
alias pac='sudo pacman -S'
alias pacy='sudo pacman -Sy'
alias pacu='sudo pacman -Syu'
alias pacuc='pacy --logfile /dev/null &>/dev/null; pacman -Qu'
alias pacr='sudo pacman -Rns'
alias paccc='sudo paccache -rvk 3'
alias yao='yaourt -S'
alias yaos='yaourt -Ss'
alias yaoi='yaourt -Si'

alias cls='echo -ne "\033c"; tmux clear-history; echo -ne "\033c"'
alias py='python3'
alias py2='python2'
alias py3='python3'
alias du1='du -d1 -h'
alias inotify='inotifywait -mrq --timefmt %F_%T --format "%T %w %e %f" -e modify,delete,create,attrib,move'
alias inotify-ao='inotifywait -mrq --timefmt %F_%T --format "%T %w %e %f" -e access,open'
alias hd='hexdump -C'
alias path='echo -e ${PATH//:/\\n}'
alias usetips='vless ~/backup/useTips'
alias errors='journalctl --priority=0..3 --catalog -n'
alias uninterruptibleSleep='ps -eo stat,args | grep "^D\|^Z"'
alias websiteget='wget -Erkp --no-parent --random-wait -U mozilla'
alias caffeine='xset s off'
alias trA2a='tr [:upper:] [:lower:]'
alias tra2A='tr [:lower:] [:upper:]'
alias ps1='echo -e "\e[01;31m\t `backlight`    `volume`     `acpi`    `date "+%y-%m-%d_%a %T"`\e[m"'
alias load='uptime | cut -d, -f3- | cut -d" " -f5-'
alias snapperlist='for name in `ls /etc/snapper/configs/`; do separatedLine; snapper --iso -c $name list; done'
alias chownr2l='sudo chown 1000:100'
alias o='rifle'
alias pss='echo "USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND"; ps -aux | grep -v grep | grep -ie $1'
alias histg='history | grep'
alias listen='lsof -P -i -n'
alias port='netstat -tulanp'
alias sniff="sudo ngrep -d 'wlo1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump='sudo tcpdump -i wlo1 -n -s 0 -w - | grep -a -o -E "Host\: .*|GET \/.*"'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias cdtmp='mkcd /tmp/tmp_$(whoami)/$(randomstr); ln -sfn $PWD ../last'
alias cdtmpl='cd /tmp/tmp_$(whoami)/last &>/dev/null; if [[ $? != 0 ]]; then cdtmp; fi'
alias clamscan='clamscan --recursive --infected --log ~/clamav.log'
type git &>/dev/null && alias diff='git diff --no-index --color-words'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
alias xclipc='xclip -selection clipboard'
alias gzipt='gzip -vc >/dev/null'
alias ffprobe-show='ffprobe -v quiet -print_format json -show_format -show_streams'
alias cpprogress='rsync -avPh'
alias date1='date +%Y%m%d%H%M%S'
alias hardlink-dry-run='>hardlink.$(date1).log hardlink --ignore-{mode,owner,time} --exclude=".git|node_modules|bower_components" --verbose --dry-run'
