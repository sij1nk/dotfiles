#!/bin/bash
# Fetch the loot table of an item / creature / object from classic wowhead,
# adapt it to AzerothCore's *_loot_template table structure, and format it
# in a way that's digestible by an SQL INSERT

fetch() 
{
    page=$(wget -qO - "https://classic.wowhead.com/${type}=${entry}")
    name=$(echo "$page" | grep -F 'og:title' | sed -E 's/^.*content="(.*)".*$/\1/')
}

# $1: number of items
write_ribbon()
{
    echo "-- ########################### $name - $1 items ##############################"
}

handle_item() 
{
    fetch

    readarray -t drops < <(echo "$page" | grep -F -A 10 "id: 'contains'" | grep -F 'data: [{"classs' | sed -E 's/.* \[(.*)\],$/\1/g;s/\},\{"classs"/\}\n\{/g')

    write_drops
}

handle_creature()
{
    fetch
    page=$(echo "$page" | grep -F "id: 'drops'")

    readarray -t drops < <(echo "$page" | grep -F 'data:[{"classs' | sed -E 's/.* \[(.*)\],$/\1/g;s/\},\{/\]\}\n\{/g')

    write_drops
}

handle_object() 
{
    fetch

    readarray -t drops < <(echo "$page" | grep -F 'data:[{"classs' | sed -E 's/.* \[(.*)\],$/\1/g;s/\},\{/\]\}\n\{/g')

    write_drops
}

write_drops()
{
    local total_count=$(echo "$page" | grep -F '_totalCount' | sed -E 's/^.*_totalCount: ([0-9]*).*$/\1/')
    write_ribbon "${#drops[@]}"
    for drop in "${drops[@]}"
    do
	local item_name=$(echo $drop | sed -E 's/^.*"name":"([^,]*)",.*$/\1/' | sed -E "s/'/\\\\\\\\'/g")
	if [ $total_count -ne 0 ]
	then
	    local count=$(echo $drop | sed -E 's/^.*"count":([0-9]*),.*$/\1/')
	    local chance=$(echo $count $total_count | awk '{printf "%.2f", $1 / $2 * 100}')
	else
	    local chance="?"
	fi
	echo $drop | sed -E "s/^.*\"id\":([0-9]*).*\"stack\":\[([0-9]*),([0-9]*)\].*$/\
\($entry, \1, 0, $chance, 0, 1, 0, \2, \3, \'$name - $item_name\'\),/g"
    done
    write_ribbon "${#drops[@]}"
}

type=$1
entry=$2

[ $# -ne 2 ] && echo "USAGE: $(basename $0) TYPE ENTRY
    TYPE: 'i' for item, 'c' for creature, 'o' for objects
    ENTRY: identifier of item/creature/object" && exit 1 

case $type in 
    i) type="item" && handle_item ;;
    c) type="npc" && handle_creature ;;
    o) type="object" && handle_object ;;
    *) echo "Invalid type: $type" && exit 1
esac 
