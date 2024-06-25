#!/usr/bin/sh

set -e

server_exec() {
  zellij -s minecraft-server action move-focus right
  zellij -s minecraft-server action write-chars "$1"
  zellij -s minecraft-server action write 10
}

server_exec "say Shutting down server in 10 minutes"
sleep 300
server_exec "say Shutting down server in 5 minutes"
sleep 240
server_exec "say Shutting down server in 1 minute"
sleep 60
server_exec "stop"

sleep 60

shutdown now
