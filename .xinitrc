USERRESOURCES=${XDG_CONFIG_HOME}/X11/Xresources
USERMODMAP=${XDG_CONFIG_HOME}/X11/.Xmodmap
REDSHIFT_TEMP_DEF=3400


# merge in defaults and keymaps
if [ -f "$USERRESOURCES" ]; then
    xrdb -merge "$USERRESOURCES"
fi

if [ -f "$USERMODMAP" ]; then
    xmodmap "$USERMODMAP"
fi

# execute scripts in xinitrc.d
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# picom &
unclutter & # Hide cursor when inactive
dwmblocks & # Status bar
dunst & # Notifications
sxhkd -m -1 & # Hotkeys (respect keyboard layout)
mpc random on # Music
acpi_listen >> /tmp/acpi.log & # Listen for acpi events
headphonesignal &s # Tell volume block to update when headphone is (un)plugged [in]
# transmission-daemon -e /tmp/transmission.log &

# Enable natural scrolling for touchpad
xinput set-prop "Elan Touchpad" "libinput Natural Scrolling Enabled" 1

# Set up keyboard layouts
setxkbmap -layout us,hu,us -variant ,102_qwerty_dot_nodead,colemak caps:swapescape,altwin:menu_win &

# Execute WM in a loop; will restart immediately after getting killed
if [ $XDG_VTNR -eq 1 ]
then
    setwallpaper # Wallpaper
    slock & # Lock the screen on login
    redshift -O $REDSHIFT_TEMP_DEF & # Night light
    echo $REDSHIFT_TEMP_DEF > /tmp/redshift_temp
    slock-when-suspended & # Lock the screen if it turns off
    while true; do
	exec /usr/local/bin/dwm
    done
else
    export LD_LIBRARY_PATH=/usr/lib64/nvidia/:/usr/lib32/nvidia:/usr/lib:${LD_LIBRARY_PATH}
    xrandr --setprovideroutputsource modesetting NVIDIA-0
    xrandr --auto

    if [ $# -gt 0 ]; then
	$*
    else
	dwm
    fi
fi
