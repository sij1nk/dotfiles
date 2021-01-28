
This is my humble and ever-evolving collection of dotfiles and shell scripts.

If you're looking for quality stuff you ought to look elsewhere as I'm still a bit of a newbie.

[Screenshots](/Pictures/lakeside_busy.png)

## Key features and principles
 - lightweight
 - ability to swap between dark and light color scheme on the fly
 - efficiency without required use of pointing devices
 - prefer slim terminal applications over huge and overengineered gooey clicky-clacky software
 - Electron is the plague

## Building blocks
 - X (display server)
 - dwm (window manager)
 - dwmblocks (status bar)
 - dmenu (custom status bar menus)
 - picom (compositor)
 - alacritty (terminal emulator)
 - zsh (shell)
 - nnn (file browser)
 - neovim (text editor)
 - isync & neomutt (e-mail)
 - sxhkd (hotkey daemon)
 - mpd & ncmpcpp (music)
 - mpv (video player)
 - ffpmeg (video recording and editing)
 - zathura (document viewer)
 - firefox (web browser)
 - transmission (pirate ship)
 - feh (image viewer)
 - redshift (night light)
 - slock (screen lock)
 - taskwarrior (todos and task management)
 - nvidia-xrun (better GPU utilization for gaming)

## dwm:

[My build of dwm](https://github.com/anguaive/dwm)

## dwmblocks:

I'm using dwmblocks, written by torrinfail. I've played around the idea of going
with something like polybar instead, but I concluded that it's needlessly
overcomplicated for my simple needs. As a result, my statusbar may not be as
fancy as it could be, and does not accept any kind of keyboard or mouse input.

Information into dwmblocks is fed by tiny shell scripts. The output of these scripts
is 'pangoified', i.e. enclosed in Pango markup, which tells dwm how to render
that particular slice of text. This allows me to recolor or resize text on the
status bar if certain conditions are met.

Status bar modules from left to right:
 - Song title + playlist index (hidden if unused)
 - Torrent upload / download (hidden if no traffic)
 - Keyboard layout (hidden if US)
 - (Unread mail)
 - Volume
 - Brightness
 - CPU and GPU temperature
 - Memory usage
 - Battery status
 - time and date
 - Internet status (missing if not connected)

The difference between my interpretations of 'missing' and 'hidden' is that
s missing modules have a certain amount of space reserved for them, while hidden modules do
not.

## dmenus:
 - keyboard layout menu: choose between ANSI us(QWERTY), ISO hu(QWERTY), and ANSI colemak mod-dh
 - color theme menu: choose which terminal color scheme to use
 - playlist menu: tell mpd which playlist to play
 - youtube-dl menu: download youtube video that the clipboarded link points to. choose format and quality
 - mount menu: mount or unmount external drives, adroid devices, virtual disks
 - display menu: choose which monitors to use (hardcoded values for my current setup)
 - shutdown menu: shutdown / reboot / suspend / turn off monitors

## Color schemes

I've created a pair of color schemes that are meant to perfectly complement my
[wallpapers](). GUI programs are not affected by them.

When selecting a color scheme from the menu, the value of the #include macro at
the top of Xresources changes accordingly and the existing color variables are
overwritten by the new ones. This affects the following applications:
 - dwm is notified, by the use of the dwmc patch - statusbar colors are updated
 - dmenu will use the new scheme on further invocations, but running instances
   are not notified
 - dunst config file is rewritten and the application is restarted
 - alacritty config file is rewritten, alacritty picks up these changes at
   runtime
 - neovim instances are notified and a function is run ("Signal" autocommand)
 - zsh instances are notified (trapping SIGUSR1)

Notifying zsh will update the terminal colors or whatever they're called, which
a lot (but not all) terminal programs depend on. Unfortunately, some programs
don't handle these variables in a very customization-friendly way, if at all.

### Archive:

![Screenshot of old setup](https://i.imgur.com/5j28PBn.png)
