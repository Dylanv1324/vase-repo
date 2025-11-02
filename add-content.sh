#!/bin/bash

# EduShare Content Management Script
# Use this script to add new subjects and lessons

MATERIALS_DIR="./materials"

print_usage() {
    echo "EduShare Content Manager"
    echo ""
    echo "Usage:"
    echo "  $0 add-subject <subject-name>"
    echo "  $0 add-lesson <subject-name> <lesson-file.txt>"
    echo "  $0 list"
    echo ""
    echo "Examples:"
    echo "  $0 add-subject geography"
    echo "  $0 add-lesson mathematics my-lesson.txt"
    echo "  $0 list"
}

add_subject() {
    local subject="$1"

    if [ -z "$subject" ]; then
        echo "Error: Subject name required"
        print_usage
        exit 1
    fi

    # Convert to lowercase and remove spaces
    subject=$(echo "$subject" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')

    if [ -d "$MATERIALS_DIR/$subject" ]; then
        echo "Subject '$subject' already exists!"
        exit 1
    fi

    mkdir -p "$MATERIALS_DIR/$subject/lessons"
    mkdir -p "$MATERIALS_DIR/$subject/resources"

    echo "✓ Subject '$subject' created successfully!"
    echo "  Add lessons to: $MATERIALS_DIR/$subject/lessons/"
    echo "  Add resources to: $MATERIALS_DIR/$subject/resources/"
}

add_lesson() {
    local subject="$1"
    local lesson_file="$2"

    if [ -z "$subject" ] || [ -z "$lesson_file" ]; then
        echo "Error: Subject name and lesson file required"
        print_usage
        exit 1
    fi

    subject=$(echo "$subject" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')

    if [ ! -d "$MATERIALS_DIR/$subject" ]; then
        echo "Error: Subject '$subject' does not exist"
        echo "Create it first with: $0 add-subject $subject"
        exit 1
    fi

    if [ ! -f "$lesson_file" ]; then
        echo "Error: Lesson file '$lesson_file' not found"
        exit 1
    fi

    cp "$lesson_file" "$MATERIALS_DIR/$subject/lessons/"

    echo "✓ Lesson added to $subject"
    echo "  Location: $MATERIALS_DIR/$subject/lessons/$(basename "$lesson_file")"
}

list_content() {
    echo "EduShare Content Structure:"
    echo ""

    if [ ! -d "$MATERIALS_DIR" ]; then
        echo "No materials directory found!"
        exit 1
    fi

    for subject_dir in "$MATERIALS_DIR"/*; do
        if [ -d "$subject_dir" ]; then
            subject=$(basename "$subject_dir")
            lesson_count=$(find "$subject_dir/lessons" -type f 2>/dev/null | wc -l)
            resource_count=$(find "$subject_dir/resources" -type f 2>/dev/null | wc -l)

            echo "📚 ${subject^}"
            echo "   Lessons: $lesson_count"
            echo "   Resources: $resource_count"

            # List lessons
            if [ $lesson_count -gt 0 ]; then
                echo "   Files:"
                find "$subject_dir/lessons" -type f -exec basename {} \; | sed 's/^/     - /'
            fi
            echo ""
        fi
    done
}

# Main
case "$1" in
    add-subject)
        add_subject "$2"
        ;;
    add-lesson)
        add_lesson "$2" "$3"
        ;;
    list)
        list_content
        ;;
    *)
        print_usage
        exit 1
        ;;
esac
