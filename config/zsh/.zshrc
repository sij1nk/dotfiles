eval "$(mcfly init zsh)"

# rose-pine scheme for tty
if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P0403c58
  \e]P1ea6f91
  \e]P29bced7
  \e]P3f1ca93
  \e]P434738e
  \e]P5c3a5e6
  \e]P6eabbb9
  \e]P7faebd7
  \e]P86f6e85
  \e]P9ea6f91
  \e]PA9bced7
  \e]PBf1ca93
  \e]PC34738e
  \e]PDc3a5e6
  \e]PEeabbb9
  \e]PFffffff
  "
  # get rid of artifacts
  clear
fi

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

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS

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

alias \
    cp="cp -v" \
    mv="mv -v" \
    mkdir="mkdir -p" \
    ls="exa -l --icons --group-directories-first" \
    grep="grep --color=auto" \
    please='sudo $(fc -nl -1)' \
    vim="vim -i NONE" \
    tmr="transmission-remote" \
    dgit="/usr/bin/git --git-dir=$HOME/Repos/dotfiles/.git --work-tree=$HOME" \
    mvn="mvn --global-settings \"$XDG_DATA_HOME/m2/settings.xml\"" \
    code="code --extensions-dir $XDG_DATA_HOME/vscode/extensions" \
    zat="zathura" \
    e="nvim" \
    mbsync="mbsync -c $XDG_CONFIG_HOME/mbsync/mbsyncrc" \
    get_idf="source $HOME/Repos/esp/esp-idf/export.sh" \
    learnvim="nvim -u $HOME/learnvim/init.vim" \
    plm="cd $HOME/Repos/bmetk-plm/" \
    plmssp="cd $HOME/Repos/bmetk-plm-server-side-processing/" \
    hx="helix" \

    function esp32 () {
	source $HOME/.scripts/esp32 $@
    }

alias \
    zpr="nvim ${ZDOTDIR}/.zprofile" \
    swy="nvim ${XDG_CONFIG_HOME}/sway/config" \
    vrc="nvim ${XDG_CONFIG_HOME}/nvim/init.vim" \
    nrc="nvim ${XDG_CONFIG_HOME}/ncmpcpp/config" \
    arc="nvim ${XDG_CONFIG_HOME}/alacritty/alacritty.yml.temp" \
    zrc="nvim ${ZDOTDIR}/.zshrc" \
    mrc="nvim ${XDG_CONFIG_HOME}/mutt/muttrc"

# TODO: fix all of these
if [ -n $DISPLAY ] && [ $XDG_VTNR -eq 1 ]; then
    # Starting out in insert mode - default prompt and cursor
    echo -ne '\e[5 q'
    PS1="%c %B❯%b "
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
	RPS1="[$VCS_STATUS]"
    else
	RPS1=""
    fi
}

# Ignore CDPATH when tab completing
zstyle ':completion*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

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

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh 2> /dev/null


ZSH_HIGHLIGHT_STYLES[builtin]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=blue,bold

ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=yellow
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[commandseparator]=white,bold
ZSH_HIGHLIGHT_STYLES[path]=underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=underline
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
ZSH_HIGHLIGHT_STYLES[globbing]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue
ZSH_HIGHLIGHT_STYLES[command-substitution]=none
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
ZSH_HIGHLIGHT_STYLES[process-substitution]=none
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=magenta
ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=cyan
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[assign]=fg=magenta
ZSH_HIGHLIGHT_STYLES[redirection]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[comment]=fg=white
ZSH_HIGHLIGHT_STYLES[named-fd]=none
ZSH_HIGHLIGHT_STYLES[arg0]=fg=white,bold

trap "source ${ZDOTDIR}/.zshrc" USR1

# vim: foldcolumn=2 foldmethod=marker
