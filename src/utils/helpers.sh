# Navigate up a specified number of directory levels
up() {
    local levels=${1:-1}
    local path=""

    for ((i = 0; i < levels; i++)); do
        path="../$path"
    done

    cd "$path" || echo "Failed to navigate to $path"
}

# Calculate the percentage change between two numbers
percentage() {
    local original_number=$1
    local new_number=$2

    if [ "$original_number" -ne 0 ]; then
        local difference=$((new_number - original_number))
        local percentage_change=$((difference * 100 / original_number))
        echo "Percentage Change: $percentage_change%"
    else
        echo "Percentage Change: Undefined (original number is 0)"
    fi
}

# Calculate the new value after applying a percentage change
percentage_value() {
    local original_number=$1
    local percent_change=$2
    local new_value=$((original_number + (original_number * percent_change / 100)))
    echo "New Value: $new_value"
}

# Multiply two numbers
mul() {
    echo "Result: $(($1 * $2))"
}

# Divide two numbers (handles division by zero)
div() {
    if [ "$2" -ne 0 ]; then
        echo "Result: $(($1 / $2))"
    else
        echo "Error: Division by zero"
    fi
}

# Run a command multiple times with specified arguments
run() {
    local times=$1
    local command=$2
    shift 2

    for ((i = 0; i < times; i++)); do
        echo -e "\e[32mRunning command $command $((i + 1)) with parameters $*...\e[0m"
        $command "$@"
        echo "Command $command $((i + 1)) completed."
    done
}