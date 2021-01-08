path+=('/home/rg/.local/bin')
path+=('.')
path+=('/home/rg/Repos/SICStus/bin')
path+=('/home/rg/.dotnet/tools')
path+=('/home/rg/.local/share/cargo/bin')
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
export TASKRC="$HOME/.config/taskwarrior/taskrc"
export GNUPGHOME="$HOME/.local/share/gnupg"
export SUDO_ASKPASS="$HOME/.local/bin/passmenu"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"

export NODE_REPL_HISTORY=""
export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export FZF_DEFAULT_COMMAND='ag -p ~/.config/ag/.ignore -g ""'
export FZF_DEFAULT_OPTS="--layout=reverse --multi --height=40% --min-height=10"

export ASPNETCORE_Kestrel__Certificates__Default__Password="localhost"
export ASPNETCORE_Kestrel__Certificates__Default__Path="/home/rg/.dotnet/corefx/cryptography/x509stores/localhost/localhost.pfx"
# x:-y -  use y if x does not exist
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

if systemctl -q is-active graphical.target && [ ! $DISPLAY ] && [ $XDG_VTNR -eq 1 ] ; then
	[ $(fgconsole 2> /dev/null) -eq 1 ] && exec startx -- -keeptty $DISPLAY -ardelay 300 -arinterval 20 &> /dev/null
fi
