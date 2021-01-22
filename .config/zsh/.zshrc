stty stop undef          # Disable ctrl-s to freeze terminal
setopt PROMPT_SUBST      # TODO: I have no clue what this does
setopt AUTO_PUSHD        # Perform pushd on every cd
setopt PUSHD_IGNORE_DUPS # Do not push duplicates onto pushd stack
setopt AUTO_CD           # If the command is a path then prepend cd
setopt GLOB_COMPLETE     # Display matches in a menu instead of inserting all of them


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

# Command aliases {{{
alias \
    cp="cp -v" \
    mv="mv -v" \
    mkdir="mkdir -p" \
    ls="LC_COLLATE=C ls -hN --color=auto --group-directories-first" \
    grep="grep --color=auto" \
    please='sudo $(fc -nl -1)' \
    vim="vim -i NONE" \
    tmr="transmission-remote" \
    nvidia-settings="nvidia-settings --config=$HOME/.config/nvidia-settings-rc" \
    dgit="/usr/bin/git --git-dir=$HOME/Repos/dotfiles/.git --work-tree=$HOME" \
    mvn="mvn --global-settings \"$XDG_DATA_HOME/m2/settings.xml\"" \
    code="code --extensions-dir $XDG_DATA_HOME/vscode/extensions" \
    z="zathura" \
    fzf="fzf --color='bg+:15,info:13,border:-1,gutter:-1,spinner:5,hl:7,fg:3,header:6,fg+:10,pointer:15,marker:6,prompt:-1,hl+:2'" \
    e="nvim"

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
if [ -n $DISPLAY ]; then

    # Set up colors from Xresources
    colors=($(xrdb -q | grep "*color" | sort -V | awk '{print $2}'))
    i=0
    for c in $colors; do
	echo -ne "\e]4;$i;$c\a"
	i=$(expr $i + 1)
    done

    color_chevron=$(xgetres "*color7")
    color_cd=$(xgetres "*color5")
    color_rprompt=$(xgetres "*color6")

    # Starting out in insert mode - default prompt and cursor
    echo -ne '\e[5 q'
    PS1="%F{$color_cd}%c%f %B%F{$color_chevron}❯%b%f "

fi

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

ZSH_HIGHLIGHT_STYLES[unknown-token]=bg=black
ZSH_HIGHLIGHT_STYLES[builtin]=fg=blue
ZSH_HIGHLIGHT_STYLES[command]=fg=blue
ZSH_HIGHLIGHT_STYLES[function]=fg=blue
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue



# vim: foldcolumn=2 foldmethod=marker
