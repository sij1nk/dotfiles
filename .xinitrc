userresources=${XDG_CONFIG_HOME}/X11/Xresources
usermodmap=${XDG_CONFIG_HOME}/X11/.Xmodmap

# merge in defaults and keymaps
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# execute scripts in xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

setwallpaper # Wallpaper
slock & # Lock the screen on login
xdotool mousemove 720 450   # Move mouse to external screen (only makes sense if external is connected)
redshift & # Night light
slock-when-suspended & # Lock the screen if it turns off
# xcompmgr & # Start compositor (needed for transparency)
picom &
unclutter & # Hide cursor when inactive
dwmblocks & # Status bar
dunst & # Notifications
sxhkd -m -1 & # Hotkeys (respect keyboard layout)
mpd && mpc random on # Music
mpcsignal & # Signals to dwmblocks on music status change
acpi_listen >> /tmp/acpi.log & # Listen for acpi events
headphonesignal &s # Tell volume block to update when headphone is (un)plugged [in]
transmission-daemon -e /tmp/transmission.log &

# Enable natural scrolling for touchpad
xinput set-prop "Elan Touchpad" "libinput Natural Scrolling Enabled" 1

# Set up keyboard layouts
setxkbmap -layout us,hu,us -variant ,102_qwerty_dot_nodead,colemak caps:swapescape,altwin:menu_win &

# Execute WM in a loop; will restart immediately after getting killed
while true; do
	exec /usr/local/bin/dwm
done
