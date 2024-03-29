path=('/home/rg/.local/bin' $path)
path+=('/home/rg/.local/share/cargo/bin')
path+=('/home/rg/.scripts')
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

export XKB_DEFAULT_LAYOUT="us,hu"
export XKB_DEFAULT_VARIANT="basic,102_qwerty_dot_nodead"
export XKB_DEFAULT_OPTIONS="caps:escape"

# Not sure if exec is needed and I don't feel like trying right now
export XDG_CURRENT_DESKTOP=Hyprland
if [ $(tty) = "/dev/tty1" ]; then
  export KYRIA=0
  exec Hyprland
fi


{{#if x11.enable}}
if [ $(tty) = "/dev/tty2" ]; then
  export KYRIA=0
  exec startx -- -keeptty $DISPLAY -ardelay 250 -arinterval 20 &> /dev/null
fi
{{/if}}
