path+=('/home/rg/.local/bin')
path+=('/home/rg/.local/share/cargo/bin')
path+=('/home/rg/.scripts')
path+=('/home/rg/.dotnet')
path+=('/home/rg/.dotnet/tools')
path+=('.')
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

export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export AUDACITY_PATH="$XDG_CONFIG_HOME/Audacity"

export GNUPGHONE="$XDG_DATA_HOME/gnupg"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GEM_HOME="$XDG_DATA_HOME/gems"
export HISTFILE="$XDG_DATA_HOME/bash_history"
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export NUGET_PACKAGES="$XDG_DATA_HOME/NuGet/packages"
export WINEPREFIX="$XDG_DATA_HOME/wine"

export QT_SCALE_FACTOR=1.5
# this breaks multimc on x11 (and probably other qt apps as well)
# export QT_QPA_PLATFORM=wayland

export LESSHISTFILE="-"
export NODE_REPL_HISTORY=""
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export LC_COLLATE="C"

export NNN_OPTS="doe"

export FZF_DEFAULT_COMMAND='ag -p ~/.config/ag/.ignore -g ""'
export FZF_DEFAULT_OPTS="--layout=reverse --multi --height=40% --min-height=10"

export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=2
export MCFLY_DISABLE_MENU=TRUE

export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

[ $(tty) = "/dev/tty1" ] && exec sway
{{#if x11.enable}}
[ $(tty) = "/dev/tty2" ] && exec startx -- -keeptty $DISPLAY -ardelay 250 -arinterval 20 &> /dev/null
{{/if}}
