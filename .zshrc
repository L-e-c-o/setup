# Path to your oh-my-zsh installation.
export ZSH="/home/leco/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting sudo extract dnf)

source $ZSH/oh-my-zsh.sh

### ALIAS ###

## Xclip
alias clip='xclip -r -sel c'

## Open
alias xdg-open='open'

## sudo
alias suod='sudo'
alias sodu='sudo'
alias sduo='suod'
alias sdou='suod'

## NeoVim
alias vim='nvim'
alias imv='nvim'
alias ivm='nvim'

## TRASH CLI "desctivé pour le tp de linux"
alias rm="trash-put"
alias rmlist="trash-list"
alias rest="restore-trash"
alias empty="trash-empty"

## NAVIGATION
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

## PROTON VPN
alias pco='protonvpn-cli c -f' 
alias ptor='protonvpn-cli c --tor'
alias pkon='protonvpn-cli ks --on'
alias pkall='protonvpn-cli ks --always-on'
alias pkoff='protonvpn-cli ks --off'
alias pstat='protonvpn-cli s'
alias pdisc='protonvpn-cli d'
alias psrv='protonvpn-cli c'

## Sync history
export PROMPT_COMMAND='history -a;history -n'

## CLEAR
alias cls="clear"

## MKDIR
alias mkdir="mkdir -vp"

## VPN HACKTHEBOX
alias htb='sudo openvpn ~/home/leco/esgi/htb/pro-labs/OFFSHORE/leco/eu-offshore-2-leco.ovpn &'

## VPN TRYHACKME
alias try='sudo openvpn /home/leco/esgi/tryhackme/leco.ovpn &'

## SHUTDOWN/REBOOT
alias shut="shutdown now"
alias reb="reboot"

### FUNCTION ###
# cd +ls -l
function cl () {
    cd "$1";
    ls -l    
}

## EXTRACT
ex () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

## WEB SERVER
function serv {
    declare -a state
    state=( $(ip a | grep -m1 "state UP" | awk -F" " '{print $2}' | sed 's/://g') $(ip a | grep -m1 "tun0" | awk -F" " '{print $2}' | sed 's/://g') )
    for i in "${state[@]}"
    do
       if [ ! -z "$i" ]; then
            echo "$i  $(ip a show $i | grep -w "inet" | awk -F" " '{print $2}')"
       fi
    done
    python3 -m http.server $1
}

## TASSIN3 WITH OUT SELINUX if error ==> before run "sudo setenforce 0" and after "sudo setenforce 1"
tassin3 () { 
    podman run --rm -v $HOME/.gnupg:/root/.gnupg:rw,Z -v $(pwd):/report:rw,Z -ti tassin3 "$@"
}

## GIT PUSH
push () {
    git pull && git add -A && git commit -m "commit $(date)" && git push
}

## inotifywait + tassin build dont forget do setenforce 1 when you are done
build () {
#    sudo setenforce 0
    while inotifywait -e modify ./* 
    do 
        notify-send "Building" && tassin3 build && notify-send "Finished"  
    done
}

## Kill process by name
k () {
	kill -9 $(pgrep $1)
}

## NMAP
scan () {
    if [ -z "$*" ]
    then
        echo "Usage : scan <TARET_IP>"
    fi
    nmap -A -Pn -p $(nmap -Pn -p- $1 | grep '^[[:digit:]]' | awk -F "/" 'BEGIN { ORS=" " };  {printf $1","}' | sed 's/.$//') $1 -oA $1
}

## VPN
vpn () {
    sudo sed -i '$s/.*/DNS=192.168.100.19 1.1.1.1/' /etc/systemd/resolved.conf && \
    sudo systemctl restart systemd-resolved && \
    sudo openvpn ~/sysdream/vpn/router-TCP4-1194-s.matthews-config.ovpn && \
    sudo sed -i '$s/.*/DNS=1.1.1.1 192.168.100.19/' /etc/systemd/resolved.conf && \
    sudo systemctl restart systemd-resolved
}

