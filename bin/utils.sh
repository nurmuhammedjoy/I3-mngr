#!/data/data/com.termux/files/usr/bin/bash

# Simple logging function
log() {
  echo "[LOG] $*"
}

# Status printing function (to match your main.sh)
show_status() {
  local status="$1"
  local message="$2"
  echo "[$status] $message"
}
