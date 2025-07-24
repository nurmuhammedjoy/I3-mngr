#!/data/data/com.termux/files/usr/bin/bash


set -euo pipefail


readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CONFIG_DIR="$HOME/.config/i3"
readonly CACHE_DIR="$HOME/.cache/i3wm-tool"
readonly LOG_FILE="$CACHE_DIR/i3wm-tool.log"


readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly MAGENTA='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly WHITE='\033[1;37m'
readonly BOLD='\033[1m'
readonly DIM='\033[2m'
readonly NC='\033[0m' 
readonly RESET='\033[0m'


readonly CHECK=""
readonly CROSS=""
readonly ARROW=""
readonly STAR=""
readonly GEAR=""
readonly PACKAGE=""
readonly THEME="󰔎"
readonly WALLPAPER="󰸉"
readonly CONFIG=""

source "$SCRIPT_DIR/bin/utils.sh"

init_environment() {
    mkdir -p "$CACHE_DIR" "$CONFIG_DIR"
    touch "$LOG_FILE"
    
    chmod 755 "$SCRIPT_DIR/bin"/*.sh 2>/dev/null || true
}

detect_terminal_caps() {
    TERM_WIDTH=$(tput cols 2>/dev/null || echo 80)
    TERM_HEIGHT=$(tput lines 2>/dev/null || echo 24)
    
    
    if [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
        COLOR_SUPPORT=$(tput colors 2>/dev/null || echo 0)
    else
        COLOR_SUPPORT=0
    fi
    
    
    if [[ $TERM_WIDTH -lt 60 ]]; then
        COMPACT_MODE=true
    else
        COMPACT_MODE=false
    fi
}

show_header() {
    clear
    local title="
██╗██████╗░  ███╗░░░███╗███╗░░██╗░██████╗░██████╗░
██║╚════██╗  ████╗░████║████╗░██║██╔════╝░██╔══██╗
██║░█████╔╝  ██╔████╔██║██╔██╗██║██║░░██╗░██████╔╝
██║░╚═══██╗  ██║╚██╔╝██║██║╚████║██║░░╚██╗██╔══██╗
██║██████╔╝  ██║░╚═╝░██║██║░╚███║╚██████╔╝██║░░██║
╚═╝╚═════╝░  ╚═╝░░░░░╚═╝╚═╝░░╚══╝░╚═════╝░╚═╝░░╚═╝"
 local version=""
    
    echo -e " ${title}"
    echo -e "         ${DIM}${version}${NC}\n"
}

show_menu() {
    local -a menu_items=(
        "1|${PACKAGE} Install i3wm|Install i3wm and dependencies"
        "2|${CONFIG} Configure i3wm|Manage i3wm configuration"
        "3|${THEME} Apply Theme|Change color scheme and appearance"
        "4|${WALLPAPER} Set Wallpaper|Change desktop wallpaper"
        "5|${GEAR} System Info|View system and i3wm status"
        "6|󰁯 Backup/Restore|Backup or restore configurations"
        "7|󰚰 Update Tool|Update i3wm-tool to latest version"
        "8|󱝧 Uninstall|Remove i3wm and configurations"
        "0|󰈆 Exit|Quit i3wm Manager"
    )
    
    local max_option_width=0
    for item in "${menu_items[@]}"; do
        IFS='|' read -r num icon desc <<< "$item"
        local item_width=$((${#num} + ${#icon} + ${#desc} + 4))
        if [[ $item_width -gt $max_option_width ]]; then
            max_option_width=$item_width
        fi
    done
    
    if [[ $max_option_width -gt $((TERM_WIDTH - 10)) ]]; then
        max_option_width=$((TERM_WIDTH - 10))
    fi
    
    echo -e "${BOLD}${WHITE}Choose an option:${NC}\n"
    
    for item in "${menu_items[@]}"; do
        IFS='|' read -r num icon desc help <<< "$item"
        
        if [[ $COMPACT_MODE == true ]]; then
            printf "  ${BOLD}${CYAN}%s${NC} %s\n" "$num" "$icon"
        else
            printf "  ${BOLD}${CYAN}%s${NC} %s ${WHITE}%s${NC}\n" "$num" "$icon" "$desc"
            if [[ -n "$help" && $TERM_HEIGHT -gt 30 ]]; then
                printf "     ${DIM}%s${NC}\n" "$help"
            fi
        fi
    done
    
    echo
    printf "${BOLD}Enter your choice [0-8]: ${NC}"
}


show_status() {
    local status="$1"
    local message="$2"
    local timestamp=$(date '+%H:%M:%S')
    
    case "$status" in
        "success")
            echo -e "${GREEN}${CHECK}${NC} ${timestamp} ${message}"
            ;;
        "error")
            echo -e "${RED}${CROSS}${NC} ${timestamp} ${message}"
            ;;
        "info")
            echo -e "${BLUE}${ARROW}${NC} ${timestamp} ${message}"
            ;;
        "warning")
            echo -e "${YELLOW}⚠${NC} ${timestamp} ${message}"
            ;;
        "processing")
            echo -e "${MAGENTA}⏳${NC} ${timestamp} ${message}"
            ;;
    esac
}


show_progress() {
    local current="$1"
    local total="$2"
    local message="$3"
    local width=40
    
    if [[ $COMPACT_MODE == true ]]; then
        width=20
    fi
    
    local percentage=$((current * 100 / total))
    local filled=$((current * width / total))
    local empty=$((width - filled))
    
    local bar=""
    for ((i=0; i<filled; i++)); do bar+="█"; done
    for ((i=0; i<empty; i++)); do bar+="░"; done
    
    printf "\r${CYAN}[${bar}]${NC} ${percentage}%% ${message}"
    
    if [[ $current -eq $total ]]; then
        echo
    fi
}



handle_menu_choice() {
    local choice="$1"
    
    case "$choice" in
        1)
            show_status "info" "Starting i3wm installation..."
            "$SCRIPT_DIR/bin/install.sh"
            ;;
        2)
            show_status "info" "Opening configuration manager..."
            "$SCRIPT_DIR/bin/config-manager.sh"
            ;;
        3)
            show_status "info" "Opening theme selector..."
            "$SCRIPT_DIR/bin/apply-theme.sh"
            ;;
        4)
            show_status "info" "Opening wallpaper manager..."
            "$SCRIPT_DIR/bin/set-wallpaper.sh"
            ;;
        5)
            show_status "info" "System Status...."
            "$SCRIPT_DIR/bin/fetch.sh"
            ;;
        6)
            show_status "info" "Opening backup/restore utility..."
            "$SCRIPT_DIR/bin/backup.sh"
            ;;
        7)
            show_status "info" "Checking for updates..."
            "$SCRIPT_DIR/bin/update.sh"
            ;;
        8)
            show_status "warning" "Starting uninstallation..."
            "$SCRIPT_DIR/bin/uninstall.sh"
            ;;
        0)
            show_status "info" "Thanks for using our i3wm Manager 󰱱"
            exit 0
            ;;
        *)
            show_status "error" "Invalid option, Please try again."
            sleep 1
            ;;
    esac
}


main() {

    init_environment
    detect_terminal_caps
    
    trap 'echo -e "\n${YELLOW}Interrupted by user${NC}"; exit 130' INT
    trap 'show_status "info" "Cleaning up..."; exit 0' EXIT
    
    while true; do
        show_header
        show_menu
        
        read -r choice
        echo
        
        
        if [[ "$choice" =~ ^[0-8]$ ]]; then
            handle_menu_choice "$choice"
        else
            show_status "error" "Please enter a number between 0-8"
            sleep 1
        fi
        
        if [[ "$choice" != "0" ]]; then
            echo
            read -p "Press Enter to return to main menu..."
        fi
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
