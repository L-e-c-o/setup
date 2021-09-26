# Path to your oh-my-zsh installation.
export ZSH="/home/leco/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting sudo extract)

source $ZSH/oh-my-zsh.sh

### ALIAS ###

## Xclip
alias clip='xclip -r -sel c'

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

## Sync history
export PROMPT_COMMAND='history -a;history -n'

## CLEAR
alias cls="clear"

## MKDIR
alias mkdir="mkdir -vp"

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

## GIT PUSH
push () {
    git pull && git add -A && git commit -m "$1" && git push
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
