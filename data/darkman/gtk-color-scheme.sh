#!/bin/sh

case "$1" in
dark) COLOR_SCHEME=prefer-dark ;;
light) COLOR_SCHEME=prefer-light ;;
default) exit 1 ;;
esac

gsettings set org.gnome.desktop.interface color-scheme "$COLOR_SCHEME"
