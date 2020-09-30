stty stop undef			# Disable ctrl-s to freeze terminal
setopt PROMPT_SUBST
setopt AUTO_PUSHD

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

# Command aliases
alias \
	ls="LC_COLLATE=C ls -hN --color=auto --group-directories-first" \
	grep="grep --color=auto" \
	please='sudo $(fc -nl -1)' \
	p="sudo pacman" \
	tmr="transmission-remote" \
	nvidia-settings="nvidia-settings --config=$HOME/.config/nvidia-settings-rc" \
	dgit="git --git-dir $HOME/Repos/dotfiles/.git --work-tree=$HOME" \
	z="zathura"

# File aliases
alias \
	zpr="nvim ${ZDOTDIR}/.zprofile" \
	xin="nvim ${HOME}/.xinitrc" \
	hky="nvim ${XDG_CONFIG_HOME}/sxhkd/sxhkdrc" \
	vrc="nvim ${XDG_CONFIG_HOME}/nvim/init.vim" \
	drc="nvim ${XDG_CONFIG_HOME}/dunst/dunstrc" \
	nrc="nvim ${XDG_CONFIG_HOME}/ncmpcpp/config" \
	arc="nvim ${XDG_CONFIG_HOME}/alacritty/alacritty.yml" \
	zrc="nvim ${ZDOTDIR}/.zshrc" \
	mrc="nvim ${XDG_CONFIG_HOME}/mutt/muttrc" \
	xrs="nvim ${XDG_CONFIG_HOME}/X11/.Xresources"

### PROMPT STUFF ###########################################
############################################################

# TODO: fix conditional
if [ -n $DISPLAY ]; then

	# Set up colors from Xresources
	colors=$(xrdb -q)

	get_xres() {
	  echo $colors | grep $1 | awk '{print $2}'
	}

	# These are the colors I'm currently using in my prompts
	# The colors could alternatively be exported as env variables
	red=$(get_xres "*color9:")
	yellow=$(get_xres "*color11:")
	lgrey=$(get_xres "*color7:")

	# Starting out in insert mode - default prompt and cursor
	echo -ne '\e[5 q'
	PS1="%F{$yellow}%c%f %B%F{$red}❯%b%f "

else
	PS1=">"
fi

# Executes every time the keymap changes
# (changing between vi modes)
function zle-keymap-select () {
  case "$KEYMAP" in
  	vicmd)
		echo -ne '\e[1 q'
		;;
	main)
		echo -ne '\e[5 q'
		;;
  esac
}
zle -N zle-keymap-select

# Executes every time a new line of input is being read
function zle-line-init () {
  echo -ne '\e[5 q'
}
zle -N zle-line-init

# Keeping track of version control branch
precmd () {
  VCS_STATUS=$(git symbolic-ref HEAD 2> /dev/null)
  if [ $? -eq 0 ]; then # If it's a git repo
    VCS_STATUS=$(echo $VCS_STATUS | cut -d'/' -f3-)
    RPS1="%F{$lgrey}[$VCS_STATUS]%f"
  else
    RPS1=""
  fi
}

### KEYBINDINGS ############################################
############################################################

bindkey -v			# vi mode
export KEYTIMEOUT=1		# Reduce latency when pressing <ESC>

# Use vim keys in tabcomplete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey '^J' down-history
bindkey '^K' up-history

# Sourcing plugins - has to be at the end of the file
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh 2> /dev/null
