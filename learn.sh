#!/bin/bash

# EduShare - Learning Materials System for Underprivileged Schools
# A lightweight, SSH-friendly educational content delivery system

# Configuration
MATERIALS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/materials"
DOWNLOAD_DIR="$HOME/my-learning-materials"

# Color definitions
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'
UNDERLINE='\033[4m'

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Bright colors
BRIGHT_RED='\033[1;31m'
BRIGHT_GREEN='\033[1;32m'
BRIGHT_YELLOW='\033[1;33m'
BRIGHT_BLUE='\033[1;34m'
BRIGHT_MAGENTA='\033[1;35m'
BRIGHT_CYAN='\033[1;36m'
BRIGHT_WHITE='\033[1;97m'

# Background colors
BG_BLUE='\033[44m'
BG_GREEN='\033[42m'
BG_CYAN='\033[46m'

# Check if terminal supports colors
if [ -t 1 ]; then
    USE_COLORS=true
else
    USE_COLORS=false
fi

# Print functions
print_header() {
    echo -e "\n${BOLD}${BRIGHT_CYAN}╔════════════════════════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${BOLD}${BRIGHT_CYAN}║${RESET}${BOLD}${BRIGHT_WHITE}                           EDUSHARE LEARNING SYSTEM                         ${RESET}${BOLD}${BRIGHT_CYAN}║${RESET}"
    echo -e "${BOLD}${BRIGHT_CYAN}║${RESET}${DIM}                    Education for Everyone, Everywhere                     ${RESET}${BOLD}${BRIGHT_CYAN}║${RESET}"
    echo -e "${BOLD}${BRIGHT_CYAN}╚════════════════════════════════════════════════════════════════════════════╝${RESET}\n"
}

print_section_header() {
    local title="$1"
    echo -e "\n${BOLD}${BRIGHT_YELLOW}━━━ ${title} ━━━${RESET}\n"
}

print_success() {
    echo -e "${BRIGHT_GREEN}✓${RESET} $1"
}

print_error() {
    echo -e "${BRIGHT_RED}✗${RESET} $1"
}

print_info() {
    echo -e "${BRIGHT_BLUE}ℹ${RESET} $1"
}

print_menu_item() {
    local number="$1"
    local text="$2"
    echo -e "  ${BOLD}${BRIGHT_CYAN}[$number]${RESET} $text"
}

# Clear screen
clear_screen() {
    clear
}

# Wait for user input
press_enter() {
    echo -e "\n${DIM}Press ENTER to continue...${RESET}"
    read -r
}

# Display lesson with ENHANCED formatting - Super colorful and fun!
display_lesson() {
    local file="$1"
    local subject="$2"

    clear_screen

    # Rainbow gradient header based on subject
    local header_color=""
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
    echo -e "${BRIGHT_YELLOW}✨ ════════════════════════════════════════════════════════════════════════ ✨${RESET}\n"

    local in_practice=false
    local in_example=false
    local line_number=0

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
            echo -e "\n${BOLD}${BRIGHT_YELLOW}🎓 ${line}${RESET}"
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
            echo -e "\n${BOLD}${BRIGHT_GREEN}▶ ${line}${RESET}"
            continue
        fi

        # "Examples:" section starter
        if [[ "$line" =~ ^[\ ]*(Example|Examples|Real-life\ Example):$ ]]; then
            echo -e "\n${BOLD}${BG_BLUE}${BRIGHT_WHITE} 💡 ${line} ${RESET}"
            in_example=true
            continue
        fi

        # "Practice" section starter
        if [[ "$line" =~ ^[\ ]*(Practice|Practice\ Problems|Practice\ Questions):$ ]]; then
            echo -e "\n${BOLD}${BG_GREEN}${BRIGHT_WHITE} ✏️  ${line} ${RESET}"
            in_practice=true
            continue
        fi

        # "Answers:" section
        if [[ "$line" =~ ^[\ ]*(Answer|Answers):.*$ ]]; then
            echo -e "\n${BOLD}${BRIGHT_MAGENTA}🔑 ${line}${RESET}"
            in_practice=false
            continue
        fi

        # "Key Points" or "Important" sections
        if [[ "$line" =~ ^[\ ]*(Key\ Points|Important|Remember|Fun\ Facts):$ ]]; then
            echo -e "\n${BOLD}${BRIGHT_YELLOW}⭐ ${line}${RESET}"
            echo -e "${BRIGHT_YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
            continue
        fi

        # Bullet points - colorful bullets
        if [[ "$line" =~ ^[\ ]*\*\ .+ ]]; then
            local content="${line#*\* }"
            echo -e "${BRIGHT_CYAN}  ● ${BRIGHT_WHITE}${content}${RESET}"
            continue
        fi

        if [[ "$line" =~ ^[\ ]*-\ .+ ]] && [[ ! "$line" =~ ^-+$ ]]; then
            local content="${line#*- }"
            echo -e "${BRIGHT_BLUE}  ◆ ${BRIGHT_WHITE}${content}${RESET}"
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
            echo -e "${BRIGHT_MAGENTA}  💭 ${line}${RESET}"
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
    echo -e "\n${BRIGHT_YELLOW}✨ ════════════════════════════════════════════════════════════════════════ ✨${RESET}"
    echo -e "${BRIGHT_GREEN}🌟 Great job reading! Keep learning! 🌟${RESET}\n"
}

# List subjects
list_subjects() {
    clear_screen
    print_header
    print_section_header "Available Subjects"

    local subjects=()
    local count=1

    for subject_dir in "$MATERIALS_DIR"/*; do
        if [ -d "$subject_dir" ]; then
            local subject=$(basename "$subject_dir")
            subjects+=("$subject")

            # Count lessons
            local lesson_count=$(find "$subject_dir/lessons" -type f 2>/dev/null | wc -l)

            # Print with icon based on subject
            case "$subject" in
                mathematics)
                    print_menu_item "$count" "📐 Mathematics (${lesson_count} lessons)"
                    ;;
                science)
                    print_menu_item "$count" "🔬 Science (${lesson_count} lessons)"
                    ;;
                english)
                    print_menu_item "$count" "📚 English (${lesson_count} lessons)"
                    ;;
                history)
                    print_menu_item "$count" "🏛️  History (${lesson_count} lessons)"
                    ;;
                *)
                    print_menu_item "$count" "📖 ${subject^} (${lesson_count} lessons)"
                    ;;
            esac
            ((count++))
        fi
    done

    echo ""
    print_menu_item "D" "Download materials for offline reading"
    print_menu_item "H" "Help & Instructions"
    print_menu_item "Q" "Quit"

    echo -e "\n${DIM}Enter your choice:${RESET} "
    read -r choice

    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -lt "$count" ]; then
        local selected_subject="${subjects[$((choice-1))]}"
        browse_lessons "$selected_subject"
    elif [[ "$choice" =~ ^[Dd]$ ]]; then
        download_materials_menu
    elif [[ "$choice" =~ ^[Hh]$ ]]; then
        show_help
    elif [[ "$choice" =~ ^[Qq]$ ]]; then
        exit 0
    else
        print_error "Invalid choice. Please try again."
        sleep 2
        list_subjects
    fi
}

# Browse lessons in a subject
browse_lessons() {
    local subject="$1"
    local lessons_dir="$MATERIALS_DIR/$subject/lessons"

    clear_screen
    print_header
    print_section_header "${subject^} - Select a Lesson"

    if [ ! -d "$lessons_dir" ] || [ -z "$(ls -A "$lessons_dir" 2>/dev/null)" ]; then
        print_error "No lessons found for $subject"
        press_enter
        list_subjects
        return
    fi

    local lessons=()
    local count=1

    for lesson_file in "$lessons_dir"/*.txt; do
        if [ -f "$lesson_file" ]; then
            lessons+=("$lesson_file")
            local lesson_name=$(basename "$lesson_file" .txt | sed 's/[0-9]*_//; s/_/ /g')
            print_menu_item "$count" "${lesson_name^}"
            ((count++))
        fi
    done

    echo ""
    print_menu_item "B" "Back to subjects"
    print_menu_item "Q" "Quit"

    echo -e "\n${DIM}Enter your choice:${RESET} "
    read -r choice

    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -lt "$count" ]; then
        local selected_lesson="${lessons[$((choice-1))]}"
        view_lesson "$selected_lesson" "$subject"
    elif [[ "$choice" =~ ^[Bb]$ ]]; then
        list_subjects
    elif [[ "$choice" =~ ^[Qq]$ ]]; then
        exit 0
    else
        print_error "Invalid choice. Please try again."
        sleep 2
        browse_lessons "$subject"
    fi
}

# View a lesson
view_lesson() {
    local lesson_file="$1"
    local subject="$2"

    display_lesson "$lesson_file" "${subject^}"

    echo -e "${DIM}Options:${RESET}"
    echo -e "  ${BRIGHT_GREEN}[S]${RESET} Save this lesson for offline reading"
    echo -e "  ${BRIGHT_CYAN}[B]${RESET} Back to lessons"
    echo -e "  ${BRIGHT_YELLOW}[M]${RESET} Main menu"
    echo -e "  ${BRIGHT_RED}[Q]${RESET} Quit"

    echo -e "\n${DIM}Enter your choice:${RESET} "
    read -r choice

    case "$choice" in
        [Ss])
            save_lesson "$lesson_file" "$subject"
            ;;
        [Bb])
            browse_lessons "$subject"
            ;;
        [Mm])
            list_subjects
            ;;
        [Qq])
            exit 0
            ;;
        *)
            browse_lessons "$subject"
            ;;
    esac
}

# Save lesson for offline reading
save_lesson() {
    local lesson_file="$1"
    local subject="$2"
    local lesson_name=$(basename "$lesson_file")

    # Create download directory
    mkdir -p "$DOWNLOAD_DIR/$subject"

    # Copy lesson
    cp "$lesson_file" "$DOWNLOAD_DIR/$subject/"

    if [ $? -eq 0 ]; then
        print_success "Lesson saved to: $DOWNLOAD_DIR/$subject/$lesson_name"
        print_info "You can read this file offline anytime!"
        print_info "Use: cat $DOWNLOAD_DIR/$subject/$lesson_name"
    else
        print_error "Failed to save lesson. Check permissions."
    fi

    press_enter
    browse_lessons "$subject"
}

# Download materials menu
download_materials_menu() {
    clear_screen
    print_header
    print_section_header "Download Materials for Offline Reading"

    echo -e "${WHITE}This feature allows you to save learning materials to your local${RESET}"
    echo -e "${WHITE}device so you can read them even when disconnected from the server.${RESET}\n"

    print_menu_item "1" "Download ALL materials (all subjects)"
    print_menu_item "2" "Download a specific subject"
    print_menu_item "3" "View my downloaded materials"
    print_menu_item "B" "Back to main menu"

    echo -e "\n${DIM}Enter your choice:${RESET} "
    read -r choice

    case "$choice" in
        1)
            download_all_materials
            ;;
        2)
            download_subject_menu
            ;;
        3)
            view_downloaded_materials
            ;;
        [Bb])
            list_subjects
            ;;
        *)
            print_error "Invalid choice."
            sleep 2
            download_materials_menu
            ;;
    esac
}

# Download all materials
download_all_materials() {
    clear_screen
    print_section_header "Downloading All Materials"

    mkdir -p "$DOWNLOAD_DIR"

    print_info "Copying all learning materials..."
    cp -r "$MATERIALS_DIR"/* "$DOWNLOAD_DIR/"

    if [ $? -eq 0 ]; then
        print_success "All materials downloaded successfully!"
        print_info "Location: $DOWNLOAD_DIR"
        print_info ""
        print_info "To read offline, use:"
        echo -e "  ${BRIGHT_CYAN}ls $DOWNLOAD_DIR${RESET}"
        echo -e "  ${BRIGHT_CYAN}cat $DOWNLOAD_DIR/[subject]/lessons/[lesson].txt${RESET}"
    else
        print_error "Download failed. Check permissions."
    fi

    press_enter
    download_materials_menu
}

# Download specific subject
download_subject_menu() {
    clear_screen
    print_section_header "Download a Specific Subject"

    local subjects=()
    local count=1

    for subject_dir in "$MATERIALS_DIR"/*; do
        if [ -d "$subject_dir" ]; then
            local subject=$(basename "$subject_dir")
            subjects+=("$subject")
            print_menu_item "$count" "${subject^}"
            ((count++))
        fi
    done

    echo ""
    print_menu_item "B" "Back"

    echo -e "\n${DIM}Enter your choice:${RESET} "
    read -r choice

    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -lt "$count" ]; then
        local selected_subject="${subjects[$((choice-1))]}"

        mkdir -p "$DOWNLOAD_DIR"
        cp -r "$MATERIALS_DIR/$selected_subject" "$DOWNLOAD_DIR/"

        if [ $? -eq 0 ]; then
            print_success "${selected_subject^} materials downloaded!"
            print_info "Location: $DOWNLOAD_DIR/$selected_subject"
        else
            print_error "Download failed."
        fi

        press_enter
        download_materials_menu
    elif [[ "$choice" =~ ^[Bb]$ ]]; then
        download_materials_menu
    else
        print_error "Invalid choice."
        sleep 2
        download_subject_menu
    fi
}

# View downloaded materials
view_downloaded_materials() {
    clear_screen
    print_section_header "Your Downloaded Materials"

    if [ ! -d "$DOWNLOAD_DIR" ] || [ -z "$(ls -A "$DOWNLOAD_DIR" 2>/dev/null)" ]; then
        print_info "You haven't downloaded any materials yet."
    else
        print_info "Downloaded materials location: $DOWNLOAD_DIR"
        echo ""

        du -sh "$DOWNLOAD_DIR" 2>/dev/null | awk '{print "  Total size: " $1}'
        echo ""

        echo -e "${BRIGHT_YELLOW}Contents:${RESET}"
        tree "$DOWNLOAD_DIR" 2>/dev/null || find "$DOWNLOAD_DIR" -type f | sed 's|^|  |'

        echo -e "\n${BRIGHT_GREEN}To read offline:${RESET}"
        echo -e "  ${BRIGHT_CYAN}cat $DOWNLOAD_DIR/[subject]/lessons/[lesson].txt${RESET}"
    fi

    press_enter
    download_materials_menu
}

# Show help
show_help() {
    clear_screen
    print_header
    print_section_header "Help & Instructions"

    echo -e "${BOLD}${BRIGHT_YELLOW}What is EduShare?${RESET}"
    echo -e "${WHITE}EduShare is a lightweight learning system designed for schools with${RESET}"
    echo -e "${WHITE}limited resources. Students can access educational materials through${RESET}"
    echo -e "${WHITE}SSH from thin clients or basic computers.${RESET}\n"

    echo -e "${BOLD}${BRIGHT_YELLOW}How to Use:${RESET}"
    echo -e "${BRIGHT_CYAN}1.${RESET} Select a subject from the main menu"
    echo -e "${BRIGHT_CYAN}2.${RESET} Choose a lesson to read"
    echo -e "${BRIGHT_CYAN}3.${RESET} Download materials to read offline (recommended!)"
    echo -e "${BRIGHT_CYAN}4.${RESET} Disconnect and let another student use the system\n"

    echo -e "${BOLD}${BRIGHT_YELLOW}Offline Reading:${RESET}"
    echo -e "${WHITE}Download materials to your account so you can read them without${RESET}"
    echo -e "${WHITE}being connected. This frees up the server for other students!${RESET}\n"

    echo -e "${BOLD}${BRIGHT_YELLOW}Tips:${RESET}"
    echo -e "${BRIGHT_GREEN}•${RESET} Download materials before disconnecting"
    echo -e "${BRIGHT_GREEN}•${RESET} Be courteous - don't stay connected longer than needed"
    echo -e "${BRIGHT_GREEN}•${RESET} Downloaded files are stored in: ${BRIGHT_CYAN}$DOWNLOAD_DIR${RESET}"
    echo -e "${BRIGHT_GREEN}•${RESET} Use 'cat' command to read downloaded materials offline\n"

    echo -e "${BOLD}${BRIGHT_YELLOW}System Requirements:${RESET}"
    echo -e "${WHITE}• SSH access to the school server${RESET}"
    echo -e "${WHITE}• Basic terminal (works on any thin client)${RESET}"
    echo -e "${WHITE}• No special software needed!${RESET}\n"

    press_enter
    list_subjects
}

# Main function
main() {
    # Check if materials directory exists
    if [ ! -d "$MATERIALS_DIR" ]; then
        print_error "Materials directory not found: $MATERIALS_DIR"
        exit 1
    fi

    # Start the application
    list_subjects
}

# Run main function
main
