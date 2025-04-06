#!/usr/bin/sh

set -x

hyprctl reload
# TODO: what if we're on dual monitor?
eww --restart open primary-single

echo "qwerty" >~/.cache/current-dotfiles
