path+=('/home/rg/.local/bin')
export PATH

export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"
export TERMINAL="alacritty"
export READER="zathura"
export PAGER="less"
export CDPATH="$HOME:.."

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export LESSHISTFILE="-"
export WGETRC="$HOME/.config/wget/wgetrc"
export GNUPGHOME="$HOME/.local/share/gnupg"
export SUDO_ASKPASS="$HOME/.local/bin/passmenu"

# x:-y -  use y if x does not exist
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm

if systemctl -q is-active graphical.target && [ ! $DISPLAY ] && [ $XDG_VTNR -eq 1 ] ; then
	[ $(fgconsole 2> /dev/null) -eq 1 ] && exec startx -- -keeptty $DISPLAY -ardelay 300 -arinterval 25 &> /dev/null
fi
