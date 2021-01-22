path+=('/home/rg/.local/bin/')
path+=('/home/rg/.local/bin/blocks')
path+=('/home/rg/.local/bin/menus')
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

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export TASKRC="$XDG_CONFIG_HOME/taskwarrior/taskrc"
export AUDACITY_PATH="$XDG_CONFIG_HOME/Audacity"
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"

export TASKDATA="$XDG_DATA_HOME/task"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME/nv"
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export NUGET_PACKAGES="$XDG_DATA_HOME/NuGet/packages"
export HISTFILE="$XDG_DATA_HOME/bash_history"
export WINEPREFIX="$XDG_DATA_HOME/wine"

export LESSHISTFILE="-"
export NODE_REPL_HISTORY=""
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export SUDO_ASKPASS="$HOME/.local/bin/passmenu"
export LESS_TERMCAP_md=$'\E[37m'
export GREP_COLORS='ms=37:mc=37:sl=:cx=:fn=35:ln=32:bn=32:se=36'
export LS_COLORS='ln=0;33:ex=0;37:ow=41;32'
export LC_COLLATE="C"
export NNN_COLORS='3333'
export NNN_OPTS='dHo'
export NNN_BMS='d:~/Downloads;r:~/Repos;c:~/.config;'
export FZF_DEFAULT_COMMAND='ag -p ~/.config/ag/.ignore -g ""'
export FZF_DEFAULT_OPTS="--layout=reverse --multi --height=40% --min-height=10"
export ASPNETCORE_Kestrel__Certificates__Default__Password="localhost"
export ASPNETCORE_Kestrel__Certificates__Default__Path="$HOME/.dotnet/corefx/cryptography/x509stores/localhost/localhost.pfx"
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

if systemctl -q is-active graphical.target && [ ! $DISPLAY ] && [ $XDG_VTNR -eq 1 ] ; then
	[ $(fgconsole 2> /dev/null) -eq 1 ] && exec startx -- -keeptty $DISPLAY -ardelay 300 -arinterval 20 &> /dev/null
fi
