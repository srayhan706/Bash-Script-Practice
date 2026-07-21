#!/bin/bash

INPUT_PATTERN="data*.txt"

check_input_file() {
    files=($INPUT_PATTERN)

    if [ ! -f "${files[0]}" ]; then
        echo "No input file found."
        exit 1
    fi

    INPUT_FILE="${files[0]}"
    echo "Input file found: $INPUT_FILE"
}

run_child_script() {
    ./child.sh "$INPUT_FILE"

    if [ $? -ne 0 ]; then
        echo "Child script failed."
        exit 1
    fi
}

run_zip_script() {
    ./zip.sh

    if [ $? -ne 0 ]; then
        echo "Zip script failed."
        exit 1
    fi
}

main() {
    check_input_file
    run_child_script
    run_zip_script
    echo "Process completed successfully."
}

main