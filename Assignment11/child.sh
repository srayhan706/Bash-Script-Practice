#!/bin/bash

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Directory does not exist."
    exit 1
fi

count=1
files=()

for file in "$DIR"/*.txt
do
    files+=("$file")

    if (( ${#files[@]} == 5 )); then
        zip "$DIR/chunk$count.zip" "${files[@]}"

        if [ $? -ne 0 ]; then
            echo "Error creating chunk$count.zip"
            exit 1
        fi

        files=()
        ((count++))
    fi
done

# Zip remaining files
if [ ${#files[@]} -gt 0 ]; then
    zip "$DIR/chunk$count.zip" "${files[@]}"

    if [ $? -ne 0 ]; then
        echo "Error creating final zip."
        exit 1
    fi
fi

echo "All zip files created successfully."