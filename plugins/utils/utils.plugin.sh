#!/usr/bin/env bash
# Utils plugin for Oh My Org
# Provides general-purpose utility functions for shell productivity

# Function to navigate up a specified number of directory levels
# Usage: up [levels]
#   levels: The number of directory levels to go up (default: 1)
up() {
    local levels=${1:-1}
    local path=""

    for ((i = 0; i < levels; i++)); do
        path="../$path"
    done

    if ! builtin cd "$path"; then
        echo "Error: Failed to navigate to $path" >&2
        return 1
    fi
}

# Function to calculate the percentage change between two numbers
# Usage: percentage <original_number> <new_number>
percentage() {
    local original_number=$1
    local new_number=$2

    if [ -z "$original_number" ] || [ -z "$new_number" ]; then
        echo "Error: Both original and new numbers are required." >&2
        return 1
    fi

    if ! [[ "$original_number" =~ ^[0-9]+$ ]] || ! [[ "$new_number" =~ ^[0-9]+$ ]]; then
        echo "Error: Both numbers must be integers." >&2
        return 1
    fi

    if [ "$original_number" -eq 0 ]; then
        echo "Percentage Change: Undefined (original number is 0)"
    else
        local difference=$((new_number - original_number))
        local percentage_change=$((difference * 100 / original_number))
        echo "Percentage Change: $percentage_change%"
    fi
}

# Function to calculate the new value after applying a percentage change
# Usage: percentage_value <original_number> <percent_change>
percentage_value() {
    local original_number=$1
    local percent_change=$2

    if [ -z "$original_number" ] || [ -z "$percent_change" ]; then
        echo "Error: Both original number and percentage change are required." >&2
        return 1
    fi

    if ! [[ "$original_number" =~ ^[0-9]+$ ]] || ! [[ "$percent_change" =~ ^[-+]?[0-9]+$ ]]; then
        echo "Error: Both inputs must be integers." >&2
        return 1
    fi

    local new_value=$((original_number + (original_number * percent_change / 100)))
    echo "New Value: $new_value"
}

# Function to multiply two numbers
# Usage: mul <number1> <number2>
mul() {
    local num1=$1
    local num2=$2

    if [ -z "$num1" ] || [ -z "$num2" ]; then
        echo "Error: Both numbers are required." >&2
        return 1
    fi

    if ! [[ "$num1" =~ ^[0-9]+$ ]] || ! [[ "$num2" =~ ^[0-9]+$ ]]; then
        echo "Error: Both numbers must be integers." >&2
        return 1
    fi

    echo "Result: $((num1 * num2))"
}

# Function to divide two numbers (handles division by zero)
# Usage: div <dividend> <divisor>
div() {
    local dividend=$1
    local divisor=$2

    if [ -z "$dividend" ] || [ -z "$divisor" ]; then
        echo "Error: Both dividend and divisor are required." >&2
        return 1
    fi

    if ! [[ "$dividend" =~ ^[0-9]+$ ]] || ! [[ "$divisor" =~ ^[0-9]+$ ]]; then
        echo "Error: Both numbers must be integers." >&2
        return 1
    fi

    if [ "$divisor" -eq 0 ]; then
        echo "Error: Division by zero" >&2
        return 1
    else
        echo "Result: $((dividend / divisor))"
    fi
}

# Function to run a command multiple times with specified arguments
# Usage: run <times> <command> [args...]
run() {
    local times=$1
    local command=$2
    shift 2

    if [ -z "$times" ] || [ -z "$command" ]; then
        echo "Error: Number of times and command are required." >&2
        return 1
    fi

    if ! [[ "$times" =~ ^[0-9]+$ ]]; then
        echo "Error: 'times' must be an integer." >&2
        return 1
    fi

    for ((i = 0; i < times; i++)); do
        echo -e "\e[32mRunning command '$command' $((i + 1)) with parameters '$*'\e[0m"
        if ! "$command" "$@"; then
            echo "Error: Command '$command' failed on iteration $((i + 1))." >&2
            return 1
        fi
        echo "Command '$command' $((i + 1)) completed."
    done
}

# Function to swap the names of two files or directories
# Usage: swap <file1> <file2>
swap() {
    local file1=$1
    local file2=$2

    if [ -z "$file1" ] || [ -z "$file2" ]; then
        echo "Error: Both file paths are required." >&2
        return 1
    fi

    if [ ! -e "$file1" ]; then
        echo "Error: File or directory '$file1' does not exist." >&2
        return 1
    fi

    if [ ! -e "$file2" ]; then
        echo "Error: File or directory '$file2' does not exist." >&2
        return 1
    fi

    local temp_name="${file1}_temp_swap_$(date +%s%N)" # Add timestamp for uniqueness
    if mv "$file1" "$temp_name" && \
       mv "$file2" "$file1" && \
       mv "$temp_name" "$file2"; then
        echo "Swapped '$file1' and '$file2' successfully."
    else
        echo "Error: Failed to swap '$file1' and '$file2'." >&2
        return 1
    fi
}

# Function to change directory, switching to parent if a file is provided
# Usage: cd <path>
cd() {
    local path=${1:-.}

    if [ -z "$1" ]; then
        # No argument provided, go to home directory
        builtin cd ~ || return 1
        return 0
    fi

    if [ -f "$path" ]; then
        # If it's a file, go to its parent directory
        path=$(dirname "$path")
    fi

    if ! builtin cd "$path"; then
        echo "Error: Failed to navigate to $path" >&2
        return 1
    fi
}

# Function to find and replace text recursively in files with specified extensions
# Usage: replace <search_text> <replace_text> [extension] [-i]
replace() {
    local search_text=$1
    local replace_text=$2
    local extension=$3
    local ignore_case=false

    # Show help
    if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ $# -eq 0 ]; then
        echo "Usage: replace <search_text> <replace_text> [extension] [-i]"
        echo "Find and replace text recursively in files"
        echo "  -i: ignore case"
        return 0
    fi

    # Check for ignore case flag
    if [ "$3" = "-i" ] || [ "$4" = "-i" ]; then
        ignore_case=true
        [ "$3" = "-i" ] && extension=""
    fi

    # Validate inputs
    if [ -z "$search_text" ] || [ -z "$replace_text" ]; then
        echo "Error: Search and replace text are required." >&2
        return 1
    fi

    # Build find command
    local pattern="*"
    if [ -n "$extension" ] && [ "$extension" != "-i" ]; then
        extension=${extension#.}
        pattern="*.${extension}"
    fi

    echo "Searching for files matching: $pattern"
    echo "Looking for text: '$search_text'"

    # Build sed command
    local sed_cmd
    if [ "$ignore_case" = true ]; then
        sed_cmd="s/${search_text}/${replace_text}/gI"
    else
        sed_cmd="s/${search_text}/${replace_text}/g"
    fi

    # Find and replace
    local count=0
    local files_found=0
    while IFS= read -r -d '' file; do
        ((files_found++))
        echo "Checking file: $file"
        if grep -q "$search_text" "$file" 2>/dev/null; then
            if sed -i "$sed_cmd" "$file" 2>/dev/null; then
                echo "Replaced text in: $file"
                ((count++))
            else
                echo "Warning: Failed to replace in: $file"
            fi
        fi
    done < <(find . -name "$pattern" -type f -print0 2>/dev/null)

    echo "Found $files_found file(s) matching pattern '$pattern'"
    echo "Replacement completed in $count file(s)."
}

# Function to create a new tmux session with a name
# Usage: tmuxn <session_name>
tmuxn() {
    local session_name=$1

    if [ -z "$session_name" ]; then
        echo "Error: Session name is required." >&2
        echo "Usage: tmuxn <session_name>" >&2
        return 1
    fi

    # Check if tmux is installed
    if ! command -v tmux >/dev/null 2>&1; then
        echo "Error: tmux is not installed." >&2
        return 1
    fi

    # Check if session already exists
    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo "Session '$session_name' already exists. Attaching to it..."
        tmux attach-session -t "$session_name"
    else
        echo "Creating new tmux session: $session_name"
        tmux new-session -s "$session_name"
    fi
}

# Function to pack files into a tar archive
# Usage: pack <file1> [file2] [file3] ...
pack() {
    local archive_name="pack.tar"

    if [ $# -eq 0 ]; then
        echo "Error: At least one file is required." >&2
        echo "Usage: pack <file1> [file2] [file3] ..." >&2
        return 1
    fi

    # Check if files exist
    for file in "$@"; do
        if [ ! -e "$file" ]; then
            echo "Error: File or directory '$file' does not exist." >&2
            return 1
        fi
    done

    echo "Creating tar archive: $archive_name"

    # Check if pv is available
    if command -v pv >/dev/null 2>&1; then
        # Calculate total size of files to archive
        local total_size
        total_size=$(du -sb "$@" 2>/dev/null | awk '{sum+=$1} END {print sum}')

        if tar -chf - "$@" | pv -s "$total_size" > "$archive_name"; then
            echo "Archive '$archive_name' created successfully with $# item(s)."
        else
            echo "Error: Failed to create archive '$archive_name'." >&2
            return 1
        fi
    else
        # Fallback to regular tar without progress
        if tar -chf "$archive_name" "$@"; then
            echo "Archive '$archive_name' created successfully with $# item(s)."
        else
            echo "Error: Failed to create archive '$archive_name'." >&2
            return 1
        fi
    fi
}

# Function to pack files into a compressed tar archive
# Usage: packz <file1> [file2] [file3] ...
packz() {
    local archive_name="pack.tar.gz"

    if [ $# -eq 0 ]; then
        echo "Error: At least one file is required." >&2
        echo "Usage: packz <file1> [file2] [file3] ..." >&2
        return 1
    fi

    # Check if files exist
    for file in "$@"; do
        if [ ! -e "$file" ]; then
            echo "Error: File or directory '$file' does not exist." >&2
            return 1
        fi
    done

    echo "Creating compressed tar archive: $archive_name"

    # Check if pv is available
    if command -v pv >/dev/null 2>&1; then
        # Calculate total size of files to archive
        local total_size
        total_size=$(du -sb "$@" 2>/dev/null | awk '{sum+=$1} END {print sum}')

        if tar -czf - "$@" | pv -s "$total_size" > "$archive_name"; then
            echo "Compressed archive '$archive_name' created successfully with $# item(s)."
        else
            echo "Error: Failed to create compressed archive '$archive_name'." >&2
            return 1
        fi
    else
        # Fallback to regular tar without progress
        if tar -czhf "$archive_name" "$@"; then
            echo "Compressed archive '$archive_name' created successfully with $# item(s)."
        else
            echo "Error: Failed to create compressed archive '$archive_name'." >&2
            return 1
        fi
    fi
}

# Function to unpack a tar archive
# Usage: unpack <tar_file>
unpack() {
    local tar_file=$1

    if [ -z "$tar_file" ]; then
        echo "Error: Tar file is required." >&2
        echo "Usage: unpack <tar_file>" >&2
        return 1
    fi

    if [ ! -f "$tar_file" ]; then
        echo "Error: File '$tar_file' does not exist." >&2
        return 1
    fi

    echo "Extracting archive: $tar_file"

    # Determine extraction method based on file extension
    case "$tar_file" in
        *.tar.gz|*.tgz)
            if tar -xzf "$tar_file"; then
                echo "Compressed tar archive '$tar_file' extracted successfully."
            else
                echo "Error: Failed to extract compressed tar archive '$tar_file'." >&2
                return 1
            fi
            ;;
        *.tar.bz2|*.tbz2)
            if tar -xjf "$tar_file"; then
                echo "Bzip2 compressed tar archive '$tar_file' extracted successfully."
            else
                echo "Error: Failed to extract bzip2 compressed tar archive '$tar_file'." >&2
                return 1
            fi
            ;;
        *.tar)
            if tar -xf "$tar_file"; then
                echo "Tar archive '$tar_file' extracted successfully."
            else
                echo "Error: Failed to extract tar archive '$tar_file'." >&2
                return 1
            fi
            ;;
        *)
            echo "Error: Unsupported archive format. Supported formats: .tar, .tar.gz, .tgz, .tar.bz2, .tbz2" >&2
            return 1
            ;;
    esac
}
