#!/usr/bin/sh

set -e

blue="\033[0;34m"
reset="\033[0m"

server_exec() {
	zellij -s minecraft-server action move-focus down
	zellij -s minecraft-server action write-chars "$1"
	zellij -s minecraft-server action write 10
}

info() {
	echo "${blue}$*${reset}"
}

dir="$HOME/Games/minecraft-server/"
date=$(date -Iminutes)
backup_filename="backup-$date.zip"

cd "$dir" || exit

info "Backing up..."
server_exec "say Backing up..."
server_exec "save-off"
server_exec "save-all"
sleep 10
zip -r "$backup_filename" world world_nether world_the_end ops.json whitelist.json server.properties
backup_size=$(du -bsh "$backup_filename" | awk '{print $1}')
server_exec "say Backup done (size: $backup_size)"
server_exec "save-on"
info "Copying backup to remote..."
rclone moveto "$(realpath "$backup_filename")" "ftb-backups:/minecraft-server-backups/$backup_filename"
info "Backup done"
