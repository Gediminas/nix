if status is-interactive

    # Variables
    set -gx fish_greeting
    set -gx fish_prompt_pwd_dir_length 0
    # set -gx TERM xterm-256color;
    # set -gx TERM screen-256color-bce; #Enable tmux Home/End keys
    # set -gx TERM screen-256color;

    # Keybindings
    bind \c\af 'clear; commandline -f repaint; source ~/.config/fish/config.fish'
    bind \cf 'clear; commandline -f repaint'

    # Aliases
    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'
    alias mkdir='mkdir -p'
    # alias h='history'
    # alias which='type -a'
    alias ..='cd ..'
    alias ...='cd ../..'
    # alias ls='exa -lag --header'

    alias ls='ls -GF --group-directories-first --color=auto --time-style=long-iso'
    alias l='ls -lh'
    alias ll='l -A'
    # alias llt='ls -lhA --timesort'
    # alias lls='ls -lhA --total-size --size short'
    # alias llss='ls -lhA --total-size --size short --sort size'

    # alias edit='vim'
    # alias ccd='clear && cd'
    # alias killpyc='find . -name \*.pyc -delete'
    # alias tmux="tmux -2"
    # alias latex="docker run -v `pwd`:/tmp latex pdflatex"
    # alias exa="$HOME/.asdf/installs/rust/nightly/bin/exa"

    alias dusk='du -sh * | sort -h'
    alias ii="clear; neofetch"

    # if hash tmux 2>/dev/null
    alias ts="tmux -u new -A -s SYSTEM"
    alias tn="tmux -u"
    alias tt="tmux -u a"
    # end
end
