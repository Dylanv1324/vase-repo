#!/bin/bash

# Test script to demonstrate the new colorful display

# Color definitions
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

BRIGHT_RED='\033[1;31m'
BRIGHT_GREEN='\033[1;32m'
BRIGHT_YELLOW='\033[1;33m'
BRIGHT_BLUE='\033[1;34m'
BRIGHT_MAGENTA='\033[1;35m'
BRIGHT_CYAN='\033[1;36m'
BRIGHT_WHITE='\033[1;97m'

BG_BLUE='\033[44m'
BG_GREEN='\033[42m'
BG_CYAN='\033[46m'

file="$1"
subject="$2"

# Rainbow gradient header based on subject
header_color=""
case "$subject" in
    *[Mm]ath*) header_color="${BG_BLUE}${BRIGHT_WHITE}" ;;
    *[Ss]cience*) header_color="${BG_GREEN}${BRIGHT_WHITE}" ;;
    *[Ee]nglish*) header_color="${BG_CYAN}${BRIGHT_WHITE}" ;;
    *[Hh]istory*) header_color="\033[45m${BRIGHT_WHITE}" ;; # Purple background
    *) header_color="${BRIGHT_MAGENTA}" ;;
esac

# Animated decorative header
echo -e "${BOLD}${BRIGHT_MAGENTA}"
echo "╔════════════════════════════════════════════════════════════════════════════╗"
echo -e "║${header_color}                                                                            ${RESET}${BOLD}${BRIGHT_MAGENTA}║"
printf "║${header_color}%*s%s%*s${RESET}${BOLD}${BRIGHT_MAGENTA}║${RESET}\n" $(((76-${#subject})/2)) "" "$subject" $(((76-${#subject}+1)/2)) ""
echo -e "║${header_color}                                                                            ${RESET}${BOLD}${BRIGHT_MAGENTA}║"
echo "╚════════════════════════════════════════════════════════════════════════════╝"
echo -e "${RESET}"

# Fun decorative line
echo -e "${BRIGHT_YELLOW}════════════════════════════════════════════════════════════════════════ ${RESET}\n"

in_practice=false
in_example=false
line_number=0

# Display content with ENHANCED syntax highlighting
cat "$file" | while IFS= read -r line; do
    ((line_number++))

    # Skip the top border (first line)
    if [[ "$line_number" -eq 1 ]] && [[ "$line" =~ ^=+$ ]]; then
        echo -e "${BOLD}${BRIGHT_CYAN}╔══════════════════════════════════════════════════════════════════════════╗${RESET}"
        continue
    fi

    # Skip the bottom border (convert to fancy)
    if [[ "$line" =~ ^=+$ ]] && [[ "$line_number" -gt 10 ]]; then
        echo -e "${BOLD}${BRIGHT_CYAN}╚══════════════════════════════════════════════════════════════════════════╝${RESET}"
        continue
    fi

    # Main Title (ALL CAPS centered)
    if [[ "$line" =~ ^[\ ]*[A-Z][A-Z\ ]+[A-Z][\ ]*$ ]] && [[ ${#line} -lt 80 ]] && [[ "$line_number" -lt 10 ]]; then
        echo -e "${BOLD}${BG_CYAN}${BRIGHT_WHITE}          ${line}          ${RESET}"
        continue
    fi

    # Lesson headers (LESSON N: ...)
    if [[ "$line" =~ ^LESSON\ [0-9]+: ]]; then
        echo -e "\n${BOLD}${BRIGHT_YELLOW}${line}${RESET}"
        echo -e "${BRIGHT_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
        continue
    fi

    # Section headers with dashes underneath
    if [[ "$line" =~ ^-+$ ]]; then
        echo -e "${BRIGHT_MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
        continue
    fi

    # Section titles (ending with colon or question mark)
    if [[ "$line" =~ ^[A-Z].+(:|[\?])$ ]] || [[ "$line" =~ ^What.*\?$ ]] || [[ "$line" =~ ^Why.*\?$ ]] || [[ "$line" =~ ^How.*\?$ ]]; then
        echo -e "\n${BOLD}${BRIGHT_GREEN}> ${line}${RESET}"
        continue
    fi

    # "Examples:" section starter
    if [[ "$line" =~ ^[\ ]*(Example|Examples|Real-life\ Example):$ ]]; then
        echo -e "\n${BOLD}${BG_BLUE}${BRIGHT_WHITE} ${line} ${RESET}"
        in_example=true
        continue
    fi

    # "Practice" section starter
    if [[ "$line" =~ ^[\ ]*(Practice|Practice\ Problems|Practice\ Questions):$ ]]; then
        echo -e "\n${BOLD}${BG_GREEN}${BRIGHT_WHITE} ${line} ${RESET}"
        in_practice=true
        continue
    fi

    # "Answers:" section
    if [[ "$line" =~ ^[\ ]*(Answer|Answers):.*$ ]]; then
        echo -e "\n${BOLD}${BRIGHT_MAGENTA}${line}${RESET}"
        in_practice=false
        continue
    fi

    # "Key Points" or "Important" sections
    if [[ "$line" =~ ^[\ ]*(Key\ Points|Important|Remember|Fun\ Facts):$ ]]; then
        echo -e "\n${BOLD}${BRIGHT_YELLOW}${line}${RESET}"
        echo -e "${BRIGHT_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
        continue
    fi

    # Bullet points - colorful bullets
    if [[ "$line" =~ ^[\ ]*\*\ .+ ]]; then
        content="${line#*\* }"
        echo -e "${BRIGHT_CYAN}  * ${BRIGHT_WHITE}${content}${RESET}"
        continue
    fi

    if [[ "$line" =~ ^[\ ]*-\ .+ ]] && [[ ! "$line" =~ ^-+$ ]]; then
        content="${line#*- }"
        echo -e "${BRIGHT_BLUE}  - ${BRIGHT_WHITE}${content}${RESET}"
        continue
    fi

    # Numbered list items (1. 2. etc)
    if [[ "$line" =~ ^[\ ]*[0-9]+\.\ .+ ]]; then
        if [[ "$in_practice" == true ]]; then
            # Practice questions in green
            echo -e "${BRIGHT_GREEN}${line}${RESET}"
        elif [[ "$in_example" == true ]]; then
            # Examples in cyan
            echo -e "${BRIGHT_CYAN}${line}${RESET}"
        else
            # Regular numbered items in yellow
            echo -e "${BRIGHT_YELLOW}${line}${RESET}"
        fi
        continue
    fi

    # Lines with equations or math operations
    if [[ "$line" =~ [0-9]+\ *[\+\-\×\*\/\=].*[0-9] ]] || [[ "$line" =~ [0-9]+\ *[\+\-\×\*\/\=] ]]; then
        echo -e "${BOLD}${BRIGHT_CYAN}  ${line}${RESET}"
        continue
    fi

    # Lines starting with "Think of:" or "Note:"
    if [[ "$line" =~ ^[\ ]*(Think\ of|Note|Remember|Tip):.*$ ]]; then
        echo -e "${BRIGHT_MAGENTA}  ${line}${RESET}"
        continue
    fi

    # Indented content (examples, sub-points)
    if [[ "$line" =~ ^\ \ \ +.+ ]]; then
        if [[ "$in_example" == true ]]; then
            echo -e "${CYAN}${line}${RESET}"
        else
            echo -e "${WHITE}${line}${RESET}"
        fi
        continue
    fi

    # Empty lines - preserve spacing
    if [[ -z "$line" ]]; then
        echo ""
        in_example=false
        continue
    fi

    # Regular paragraph text
    echo -e "${BRIGHT_WHITE}${line}${RESET}"
done

# Fun footer
echo -e "\n${BRIGHT_YELLOW}════════════════════════════════════════════════════════════════════════ ${RESET}"
echo -e "${BRIGHT_GREEN}Great job reading! Keep learning! ${RESET}\n"
