# eval "$(pyenv init -)"
eval "$(mcfly init zsh)"

stty stop undef          # Disable ctrl-s to freeze terminal
setopt PROMPT_SUBST      # TODO: I have no clue what this does
setopt AUTO_PUSHD        # Perform pushd on every cd
setopt PUSHD_IGNORE_DUPS # Do not push duplicates onto pushd stack
setopt GLOB_COMPLETE     # Display matches in a menu instead of inserting all of them
setopt INC_APPEND_HISTORY # Append to the history immediately
setopt EXTENDED_HISTORY # Record timestamp of each command

# Autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

zmodload zsh/zle

# Zoxide (fancier cd command)
eval "$(zoxide init zsh)"

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS

# nnn {{{
n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
# }}}

# Command aliases {{{
alias \
    cp="cp -v" \
    mv="mv -v" \
    mkdir="mkdir -p" \
    ls="exa -l --icons --group-directories-first" \
    grep="grep --color=auto" \
    please='sudo $(fc -nl -1)' \
    vim="vim -i NONE" \
    tmr="transmission-remote" \
    nvidia-settings="nvidia-settings --config=$HOME/.config/nvidia-settings-rc" \
    dgit="/usr/bin/git --git-dir=$HOME/Repos/dotfiles/.git --work-tree=$HOME" \
    mvn="mvn --global-settings \"$XDG_DATA_HOME/m2/settings.xml\"" \
    code="code --extensions-dir $XDG_DATA_HOME/vscode/extensions" \
    zat="zathura" \
    fzf="fzf --color='bg+:15,info:13,border:-1,gutter:-1,spinner:5,hl:7,fg:3,header:6,fg+:10,pointer:15,marker:6,prompt:-1,hl+:2'" \
    e="nvim" \
    mbsync="mbsync -c $XDG_CONFIG_HOME/mbsync/mbsyncrc" \
    get_idf="source $HOME/Repos/esp/esp-idf/export.sh" \
    learnvim="nvim -u $HOME/learnvim/init.vim" \
    eu="eureka" \
    tk="cd ~/Repos/bmetk-plm" \
    tkssp="cd ~/Repos/bmetk-plm-server-side-processing/"

    function esp32 () {
	source $HOME/.local/bin/scripts/esp32 $1 $2 $3
    }


# }}}

# File aliases {{{
alias \
    zpr="nvim ${ZDOTDIR}/.zprofile" \
    xin="nvim ${HOME}/.xinitrc" \
    hky="nvim ${XDG_CONFIG_HOME}/sxhkd/sxhkdrc" \
    vrc="nvim ${XDG_CONFIG_HOME}/nvim/init.vim" \
    drc="nvim ${XDG_CONFIG_HOME}/dunst/dunstrc" \
    nrc="nvim ${XDG_CONFIG_HOME}/ncmpcpp/config" \
    arc="nvim ${XDG_CONFIG_HOME}/alacritty/alacritty.yml.temp" \
    zrc="nvim ${ZDOTDIR}/.zshrc" \
    mrc="nvim ${XDG_CONFIG_HOME}/mutt/muttrc"

# }}}

# TODO: fix all of these
if [ -n $DISPLAY ] && [ $XDG_VTNR -eq 1 ]; then

    # Set up colors from Xresources
    colors=($(xrdb -q | grep "*color" | sort -V | awk '{print $2}'))
    i=0
    for c in $colors; do
	echo -ne "\e]4;$i;$c\a"
	i=$(expr $i + 1)
    done

    color_chevron=$(xgetres "color8")
    color_cd=$(xgetres "color7")
    color_rprompt=$(xgetres "*color5")

    # Starting out in insert mode - default prompt and cursor
    echo -ne '\e[5 q'
    PS1="%F{$color_cd}%c%f %B%F{$color_chevron}❯%b%f "
else
    PS1="%c %% "
fi

function debug-colors() {
    echo "0 \033[0;40mblack\033[0m   \033[0;30mblack\033[0m   \033[1;30mBLACK\033[0m" 
    echo "1 \033[0;41mred\033[0m     \033[0;31mred\033[0m     \033[1;31mRED\033[0m"
    echo "2 \033[0;42mgreen\033[0m   \033[0;32mgreen\033[0m   \033[1;32mGREEN\033[0m" 
    echo "3 \033[0;43myellow\033[0m  \033[0;33myellow\033[0m  \033[1;33mYELLOW\033[0m" 
    echo "4 \033[0;44mblue\033[0m    \033[0;34mblue\033[0m    \033[1;34mBLUE\033[0m" 
    echo "5 \033[0;45mmagenta\033[0m \033[0;35mmagenta\033[0m \033[1;35mMAGENTA\033[0m" 
    echo "6 \033[0;46mcyan\033[0m    \033[0;36mcyan\033[0m    \033[1;36mCYAN\033[0m" 
    echo "7 \033[0;47mwhite\033[0m   \033[0;37mwhite\033[0m   \033[1;37mWHITE\033[0m" 
}

# Executes every time the keymap changes
# (changing between vi modes)
function zle-keymap-select () {
    case "$KEYMAP" in
	vicmd)
	    echo -ne '\e[1 q' ;;
	main)
	    echo -ne '\e[5 q' ;;
    esac
}
zle -N zle-keymap-select

# Executes every time a new line of input is being read
function zle-line-init () {
    echo -ne '\e[5 q'
}
zle -N zle-line-init

# Display git branch on right side prompt if cd is a repository
precmd () {
    VCS_STATUS=$(git symbolic-ref HEAD 2> /dev/null)
    if [ $? -eq 0 ]; then # If it's a git repo
	VCS_STATUS=$(echo $VCS_STATUS | cut -d'/' -f3-)
	RPS1="%F{$color_rprompt}[$VCS_STATUS]%f"
    else
	RPS1=""
    fi
}

# Ignore CDPATH when tab completing
zstyle ':completion*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

# Keybinds {{{
bindkey -v			# vi mode
export KEYTIMEOUT=1		# reduce latency when pressing <ESC>

# Use vim keys in tabcomplete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

for keymap in $(bindkey -l | tail); do
    bindkey -M $keymap '^J' down-history
    bindkey -M $keymap '^K' up-history
    # Disable dumb characters in all keymaps
    bindkey -M $keymap -s '^[[A'  '' # Up arrow
    bindkey -M $keymap -s '^[[B'  '' # Down arrow
    bindkey -M $keymap -s '^[[C'  '' # Right arrow
    bindkey -M $keymap -s '^[[D'  '' # Left arrow
    bindkey -M $keymap -s '^[[2~' '' # Insert
    bindkey -M $keymap -s '^[[3~' '' # Delete
    bindkey -M $keymap -s '^[[H'  '' # Home
    bindkey -M $keymap -s '^[[F'  '' # End
    bindkey -M $keymap -s '^[[5~' '' # PgUp
    bindkey -M $keymap -s '^[[6~' '' # PgDn
done

# }}}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh 2> /dev/null

trap "source ${ZDOTDIR}/.zshrc" USR1


# vim: foldcolumn=2 foldmethod=marker
