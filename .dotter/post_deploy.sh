#!/usr/bin/sh

set -x

hyprctl reload
eww --restart open primary
