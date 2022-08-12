USERRESOURCES=${XDG_CONFIG_HOME}/X11/Xresources
USERMODMAP=${XDG_CONFIG_HOME}/X11/.Xmodmap

if [ -f "$USERRESOURCES" ]; then
  xrdb -merge "$USERRESOURCES"
fi

if [ -f "$USERMODMAP" ]; then
  xmodmap "$USERMODMAP"
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

setxkbmap -layout us,hu -variant ,102_qwerty_dot_nodead caps:swapescape,altwin:menu_win &

if [ $XDG_VTNR -eq 2 ]
then
  while true; do
    exec /usr/bin/openbox-session
  done
fi
