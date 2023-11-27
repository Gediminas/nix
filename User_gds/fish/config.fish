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

    # set --global fish_prompt_pwd_dir_length 0
    # set --global hydro_multiline      true
    # set --global hydro_color_pwd      "00FF00"
    # set --global hydro_color_prompt   "00FF00"
    # set --global hydro_color_git      "5555FF"
    # set --global hydro_color_error    "FF5555"
    # set --global hydro_color_duration "555555"
    # set --global hydro_cmd_duration_threshold "1000000000"
    # set --global hydro_fetch          false
    
    # set -g __fish_git_prompt_show_informative_status 1
    # # set -g __fish_git_prompt_hide_untrackedfiles 1

    # set -g __fish_git_prompt_color_branch magenta bold
    # set -g __fish_git_prompt_showupstream "informative"
    # set -g __fish_git_prompt_char_upstream_ahead "↑"
    # set -g __fish_git_prompt_char_upstream_behind "↓"
    # set -g __fish_git_prompt_char_upstream_prefix ""

    # set -g __fish_git_prompt_char_stagedstate "●"
    # set -g __fish_git_prompt_char_dirtystate "✚"
    # set -g __fish_git_prompt_char_untrackedfiles "…"
    # set -g __fish_git_prompt_char_conflictedstate "✖"
    # set -g __fish_git_prompt_char_cleanstate "✔"

    # set -g __fish_git_prompt_color_dirtystate blue
    # set -g __fish_git_prompt_color_stagedstate yellow
    # set -g __fish_git_prompt_color_invalidstate red
    # set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    # set -g __fish_git_prompt_color_cleanstate green bold

    set -gx fish_prompt_pwd_dir_length 0
    set -g __fish_git_prompt_show_informative_status 1
    set -g __fish_git_prompt_showupstream informative
    # set -g __fish_git_prompt_hide_untrackedfiles 0
    set -g __fish_git_prompt_color_branch "#5555FF" --bold
    set -g __fish_git_prompt_color_stagedstate green
    set -g __fish_git_prompt_color_dirtystate yellow
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_untrackedfiles white
    set -g __fish_git_prompt_color_cleanstate green --bold

    function humantime --argument-names ms --description "Turn milliseconds into a human-readable string"
        set --query ms[1] || return

        set --local secs (math --scale=1 $ms/1000 % 60)
        set --local mins (math --scale=0 $ms/60000 % 60)
        set --local hours (math --scale=0 $ms/3600000 % 24)
        set --local days (math --scale=0 $ms/86400000)

        test $days -gt 0 && set --local --append out $days"d"
        test $hours -gt 0 && set --local --append out $hours"h"
        test $mins -gt 0 && set --local --append out $mins"m"
        test $secs -gt 0 && set --local --append out $secs"s"

        set --query $out && echo $out || echo $ms"ms"
    end
    
    function fish_prompt --description 'Write out the prompt'
        set -l last_pipestatus $pipestatus
        set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

        # PWD
        set_color "#00FF00" --bold
        echo -n (prompt_pwd)

        # GIT
        set_color normal
        echo -n (fish_vcs_prompt)

        # STATUS
        if [ -n "$last_pipestatus" ]
            set -l status_color (set_color $fish_color_status)
            set -l statusb_color (set_color --bold $fish_color_status)
            set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
            echo -n " "$prompt_status
        end

        # DURATION
        if test $CMD_DURATION -gt 0
            set_color "#555555"
            # echo -n " " (math $CMD_DURATION / 1000)s
            echo -n " "$(humantime $CMD_DURATION)
        end

        # PREFIX
        set_color "#FFFF00" --bold
        echo -en "\n❱ "
        set_color normal
    end

    

    set -x DIRENV_LOG_FORMAT ""
    set -g fish_key_timeout 5000
    # set -g fish_key_timeout 500  # Set the timeout to 15.000 milliseconds (adjust as needed)
    # set -gx DIRENV_DELAY 25  # Set the delay to 5 seconds (adjust as needed)

    # Keybindings

    # FIXME zellij
    # OK:
    bind \ef 'exec fish --login; clear'
    bind \cf 'clear; commandline -f repaint'

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
