# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export C_INCLUDE_PATH=/usr/lib/modules/$(uname -r)/build/include/

# export LC_ALL=custom.UTF-8
# export LC_TIME=lt_LT.UTF8
# export LC_ALL=C
# export LANG=lt_LT.UTF-8
# export LC_COLLATE=lt_LT.UTF-8
# export LC_TIME=lt_LT.UTF8

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/bin:$HOME/.local/bin:$HOME/scripts:$PATH"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Autosuggest still completes on right arrow after incompatible paste
# https://github.com/zsh-users/zsh-autosuggestions/issues/489
#ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
#ZSH_CUSTOM=~/.oh-my-zsh/custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  command-not-found
  zsh-autosuggestions
  zsh-syntax-highlighting
  git github
  node npm 
  brew macos
  # tmux
)

# ZSH_TMUX_AUTOSTART=true
# ZSH_TMUX_AUTOCONNECT=true
# ZSH_TMUX_AUTOQUIT=false
# ZSH_TMUX_FIXTERM=true
# ZSH_TMUX_UNICODE=true

unsetopt share_history
source $ZSH/oh-my-zsh.sh


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
# export EDITOR='vim'
# else
export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

gds-clear-screen() {printf "\033c"; zle redisplay}
zle -N gds-clear-screen

#bindkey -v                       # Enable Vim mode in ZSH
#bindkey '^f'  gds-clear-screen   # Ctrl+f      - clear screen and restore ohmyzsh prompt
bindkey '^f'  gds-clear-screen   # Ctrl+f      - clear screen and restore ohmyzsh prompt
#bindkey '^H' backward-kill-word  # Ctrl+H/Bspc - delete word
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

alias ..d="cd ~/dev"
alias ..dp="cd ~/dev/playground"
alias ..n="cd ~/nord"
alias ..nl="cd ~/nord/libtelio"

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

case `uname` in
  Darwin)
    # echo 'Darwin'
    alias ls='gls -GF --group-directories-first --color=auto --time-style=long-iso'
  ;;
  Linux)
    # echo 'Linux'
    eval "`dircolors`"
    alias ls='ls -GF --group-directories-first --color=auto --time-style=long-iso'
  ;;
esac

# alias ls='/usr/bin/lsd --group-dirs=first --classify --date +"%Y-%m-%d %H:%M:%S"'
alias l='ls -lh'
alias ll='l -A'
alias llt='ls -lhA --timesort'
alias lls='ls -lhA --total-size --size short'
alias llss='ls -lhA --total-size --size short --sort size'

# To avoid making mistakes:
# alias rm='rm -i'   
# alias cp='cp -i'   
# alias mv='mv -i'

# Helper
alias dusk='du -sh * | sort -h'

# History
# setopt extended_history
# setopt no_inc_append_history
# setopt no_share_history
unsetopt share_history

# MacOS
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Python
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# GoLang
if hash go 2>/dev/null; then
  #export GO111MODULE=off
  export GOPRIVATE="bucket.digitalarsenal.net"
  export GOPATH="$HOME/.go"
  export GOROOT="/usr/lib/go"
  export PATH="$PATH:$GOPATH/bin"
fi

alias ii="clear; neofetch"

# run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.config/broot/launcher/bash/br ]] && source ~/.config/broot/launcher/bash/br

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if hash tmux 2>/dev/null; then
  # [[ ! $TERM =~ tmux && ! $TERM =~ screen && ! $TERM =~ linux ]] && echo "$TERM is OK for tmux"
  # [[ ! $TERM =~ tmux && ! $TERM =~ screen && ! $TERM =~ linux ]] && [[ -z $TMUX ]] && echo "  and no tmux yet"

  # tmux

  # if [[ -z $TMUX ]]; then
  #   # if [[ ! $TERM =~ tmux && ! $TERM =~ screen && ! $TERM =~ linux ]]; then
  #   #   tmux -u
  #   #   # tmux switch -t System
  #   #   # tmux new -As System
  #   # fi
  # else
  #   tmux
  # fi

  alias ts="tmux -u new -A -s System"
  alias tt="tmux -u"
  alias ta="tmux -u a"

  # switch between light and dark themes
  #alias tl="tmux source-file ~/.tmux/themes/light.conf; tmux set-environment THEME 'light'"
  #alias td="tmux source-file ~/.tmux/themes/dark.conf; tmux set-environment THEME 'dark'"
  ## check if we have been switched to light, else go dark
  #[[ ! $(tmux show-environment | grep THEME) =~ 'THEME=light' ]] && 
  #tmux set-environment THEME dark
fi

#export VISUAL=nvim
#export EDITOR=$VISUAL
#export PAGER=less

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

