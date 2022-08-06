path+=('/home/rg/.local/bin')
path+=('/home/rg/.local/bin/blocks')
path+=('/home/rg/.local/bin/menus')
path+=('/home/rg/.local/bin/scripts')
path+=('.')
path+=('/home/rg/Repos/SICStus/bin')
path+=('/home/rg/.dotnet/tools')
path+=('/home/rg/.local/share/cargo/bin')
path+=('/home/rg/.local/share/gem/ruby/3.0.0/bin')
path+=('/home/rg/Research/src')
path+=('/home/rg/Repos/rust-tools/target/release')
export PATH

export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"
export TERMINAL="alacritty"
export READER="zathura"
export PAGER="less"
export CDPATH="$HOME:.."

# export CXX="/usr/bin/ccache /usr/bin/clang++"
# export CMAKE_GENERATOR="Ninja"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export TASKRC="$XDG_CONFIG_HOME/taskwarrior/taskrc"
export AUDACITY_PATH="$XDG_CONFIG_HOME/Audacity"
# export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"

export TASKDATA="$XDG_DATA_HOME/task"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GEM_HOME="$XDG_DATA_HOME/gems"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export __GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME/nv"
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export NUGET_PACKAGES="$XDG_DATA_HOME/NuGet/packages"
export HISTFILE="$XDG_DATA_HOME/bash_history"
export WINEPREFIX="$XDG_DATA_HOME/wine"

export NOTES_DIR="/home/rg/Notes"

export LESSHISTFILE="-"
export NODE_REPL_HISTORY=""
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export SUDO_ASKPASS="$HOME/.local/bin/menus/passmenu"
# TODO: make these colorscheme dependent
export LESS_TERMCAP_md=$'\E[1;36m'
# export LS_COLORS="ln=0;33:ex=1;35:ow=41;32:di=1;37"
# export NNN_COLORS='6666'
export NNN_FCOLORS='030304020006060001030501'
# firefox pixel-by-pixel touchpad scrolling
export MOZ_USE_XINPUT=1
export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=2
export MCFLY_DISABLE_MENU=TRUE

export QT_SCALE_FACTOR=1.5

export LC_COLLATE="C"
export NNN_OPTS='do'
export NNN_BMS='d:~/Downloads;r:~/Repos;c:~/.config;'
export FZF_DEFAULT_COMMAND='ag -p ~/.config/ag/.ignore -g ""'
export FZF_DEFAULT_OPTS="--layout=reverse --multi --height=40% --min-height=10"
export ASPNETCORE_Kestrel__Certificates__Default__Password="localhost"
export ASPNETCORE_Kestrel__Certificates__Default__Path="$HOME/.dotnet/corefx/cryptography/x509stores/localhost/localhost.pfx"
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

export STATICAPP_MON=0
export STATICAPP_TAG=1

# NOTE(rg): sometimes graphical.target is not active at this point and startx doesn't run
# if systemctl -q is-active graphical.target && [ ! $DISPLAY ] && [ $XDG_VTNR -eq 1 ] ; then
if [ -z "$DISPLAY" ] && [ $XDG_VTNR -eq 1 ]; then
	[ $(fgconsole 2> /dev/null) -eq 1 ] && exec startx -- -keeptty $DISPLAY -ardelay 250 -arinterval 20 &> /dev/null
fi
