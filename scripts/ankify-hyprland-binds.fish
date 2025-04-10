#!/usr/bin/env fish

function __print_modmask -a modmask
    [ (math bitor $modmask, 64) = $modmask ] && printf G # gui
    [ (math bitor $modmask, 8) = $modmask ] && printf A # alt
    [ (math bitor $modmask, 4) = $modmask ] && printf C # ctrl
    [ (math bitor $modmask, 1) = $modmask ] && printf S # shift
    printf "\n"
end

set binds_string (hyprctl binds -j | jq -r 'map(select(.has_description) | [.description, .submap, .modmask, .key] | @tsv) | @sh')
set binds (string split "' '" $binds_string)

for bind in $binds
    set parts (string trim --chars "'" $bind | string split (echo -e '\t'))
    set parts[3] (__print_modmask $parts[3])
    echo (string join "|" $parts)
end

functions --erase __print_modmask
