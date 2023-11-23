if status is-interactive
    # function fish_right_prompt
    #     #intentionally left blank
    # end
 
    fish_add_path "/home/gds/scripts"
    # Variables
    set -gx fish_greeting
    set -gx fish_prompt_pwd_dir_length 0
    # set -gx TERM xterm-256color;
    # set -gx TERM screen-256color-bce; #Enable tmux Home/End keys
    # set -gx TERM screen-256color;

    set --global fish_prompt_pwd_dir_length 0
    set --global hydro_multiline      true
    set --global hydro_color_pwd      "00FF00"
    set --global hydro_color_git      "777777"
    set --global hydro_color_error    "FF0000"
    set --global hydro_color_prompt   "FFFF00"
    set --global hydro_color_duration "444444"
    

    set -x DIRENV_LOG_FORMAT ""
    # set -g fish_key_timeout 500  # Set the timeout to 15.000 milliseconds (adjust as needed)
    # set -gx DIRENV_DELAY 25  # Set the delay to 5 seconds (adjust as needed)

    # Keybindings

    # FIXME zellij
    # OK:
    bind \cf 'exec fish --login; clear'
    bind \ef 'clear; commandline -f repaint'

    # experimental:
    # bind \c\af 'clear; commandline -f repaint; source ~/.config/fish/config.fish'
    # bind \e\[c 'commandline -f repaint'
    # bind \ec 'commandline -f repaint'
    # bind \cc 'commandline -f repaint'  # Map Ctrl+C to repaint
    # bind \ec 'kill -s INT (jobs -l | awk "/%+/ {print \$2}")'  # Map Alt+C to send SIGINT
    # bind \cd delete-char  # Don't exit on accidental Ctrl-D
    # bind \cd\cd\cd delete-or-exit  # Exit on the third one
    # bind \ed delete-or-exit  # Don't exit on accidental Ctrl-D

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

    # alias zellij="/home/gds/dev/zellij/target/release/zellij"
    # alias zn="/home/gds/dev/zellij/target/release/zellij -s"
    alias zz="/home/gds/dev/zellij/target/release/zellij"
    

    # alias e="nvim"
    alias e="hx"
end
