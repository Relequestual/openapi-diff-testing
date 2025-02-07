#!/bin/bash

# Define tools and their commands using indexed arrays
tools=("openapi-changes" "oasdiff" "openapi-diff" "optic")
commands=("openapi-changes -b -n -m summary" "oasdiff changelog" "openapi-diff" "optic diff")

check_tool_installed() {
    command "$1" --version >/dev/null 2>&1 || { echo >&2 "$1 is not installed. Aborting."; exit 1; }
}

run_comparisons() {
    local tool=$1
    local command=$2
    local baseline=$3
    local folder=$4

    check_tool_installed "$tool"

    for changed in "$folder"/*; do
        if [ -f "$changed" ]; then
            local result_file
            result_file="./results/${tool}_$(basename "$changed").txt"
            $command "$baseline" "$changed" > "$result_file"
            echo "Saved result to $result_file"
        fi
    done
}

all_tools=false
while getopts "a" opt; do
    case $opt in
        a)
            all_tools=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done
shift $((OPTIND -1))


if [ "$all_tools" = true ]; then
    baseline=$1
    folder=${2:-"./test-oads/"}
    for i in "${!tools[@]}"; do
        run_comparisons "${tools[$i]}" "${commands[$i]}" "$baseline" "$folder"
    done
else
    tool=$1
    baseline=$2
    folder=${3:-"./test-oads/"}
    for i in "${!tools[@]}"; do
        if [ "${tools[$i]}" = "$tool" ]; then
            run_comparisons "$tool" "${commands[$i]}" "$baseline" "$folder"
            break
        fi
    done
fi