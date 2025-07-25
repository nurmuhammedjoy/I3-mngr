#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGE_DIR="$SCRIPT_DIR/packages"

detect_package_manager() {
    if command -v apt &>/dev/null && [[ $(uname -o) != *Android* ]]; then
        echo "apt"
    elif command -v pacman &>/dev/null; then
        echo "pacman"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v apk &>/dev/null; then
        echo "apk"
    elif command -v pkg &>/dev/null; then
        echo "termux"
    else
        echo "unknown"
    fi
}

install_packages() {
    local manager
    manager=$(detect_package_manager)
    local pkg_file="$PACKAGE_DIR/${manager}-packages"

    if [[ ! -f "$pkg_file" ]]; then
        echo "[error] Package list for $manager not found: $pkg_file"
        exit 1
    fi

    mapfile -t packages < "$pkg_file"

    echo "[info] Installing packages for $manager..."

    case "$manager" in
        termux)
          
            echo "[info] Enabling x11-repo..."
            yes | pkg install -y x11-repo >/dev/null 2>&1

            echo "[info] Installing packages..."
            for pkg in "${packages[@]}"; do
                echo "    - $pkg"
                yes | pkg install -y "$pkg" >/dev/null 2>&1
            done
            echo "[info] Running initialise script..."
            bash "$SCRIPT_DIR/script/initialise"

            ;;
        apt)
            sudo apt update -qq
            sudo apt install -y "${packages[@]}"
            ;;
        pacman)
            sudo pacman -Syu --noconfirm "${packages[@]}"
            ;;
        dnf)
            sudo dnf install -y "${packages[@]}"
            ;;
        apk)
            sudo apk add "${packages[@]}"
            ;;
        *)
            echo "[error] Unsupported or unknown package manager: $manager"
            exit 1
            ;;
    esac
}


install_packages
