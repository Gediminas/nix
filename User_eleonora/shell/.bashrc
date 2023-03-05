export BASH_CONF="~/.bashrc"
export LC_ALL=en_US.UTF-8

#export EMACS='t'
#export GOROOT=/usr/local/go
#export GOPATH=~/dev/go
#export PATH=$PATH:$GOROOT/bin
#export PATH=$PATH:$GOPATH/bin

export PATH=.:/usr/local/bin:~/dev/scripts:$PATH
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'

# Some more alias to avoid making mistakes:
alias ls='ls -GFh'
alias rm='rm -i'   
alias cp='cp -i'   
alias mv='mv -i'

# Enable Vim mode
set -o vi

bind -x '"\C-f": clear'               # Ctrl+F      - clear screen
bind -x '"\C-h": backward-kill-word'  # Ctrl+H/Bspc - delete word

# https://stackoverflow.com/questions/48796132/tmux-prints-long-commands-to-beginning-of-same-line-without-line-break
# if [[ $TERM =~ 256color ]]; then
#     # PS1='\e[93m\w\e[0m\$ '
#     PS1='\w\e\$ '
# else
#     PS1='\w\e\$ '
# fi

# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
HISTCONTROL=ignoredups:erasedups  # Avoid duplicates
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend  # When the shell exits, append to the history file instead of overwriting it
# Save and reload the history after each command finishes
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# END

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias .........="cd ../../../../../../../.."
alias ..........="cd ../../../../../../../../.."
alias ...........="cd ../../../../../../../../../.."
alias ............="cd ../../../../../../../../../../.."
alias .............="cd ../../../../../../../../../../../.."

alias ..r="cd ~/dev/repo"
alias ..n="cd ~/nord"
alias ..nr="cd ~/nord/repo"

#alias ggt2="go test -v . | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/''"
#alias ggt="grc go test -v ."

# GoLang
if hash go 2>/dev/null; then
  #export GO111MODULE=off
  export GOPRIVATE="bucket.digitalarsenal.net"
  export GOPATH="$HOME/.go"
  export GOROOT="/usr/lib/go"
  export PATH="$PATH:$GOPATH/bin"
fi

# Rust

if [[ $- == *i* ]]; then  #if !scp
  stty -ixon  #disable Ctrl+w/q  

  bind '"\e[A":history-search-backward'
  bind '"\e[B":history-search-forward'

  # echo -e "\e[32m[BASH_CONF: $BASH_CONF]\e[0m"
  # echo -e "\e[32m[PATH: $PATH]\e[0m"
  # echo -e "\e[32m=============================\e[0m"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

