#!/bin/bash

DIR="myfiles"

# Check if directory exists
if [ ! -d "$DIR" ]; then
    mkdir "$DIR"

    if [ $? -ne 0 ]; then
        echo "Error: Failed to create directory."
        exit 1
    fi
fi

# Clean directory
rm -f "$DIR"/*

if [ $? -ne 0 ]; then
    echo "Error: Failed to clean directory."
    exit 1
fi

# Create 20 files
for i in {1..20}
do
    echo "This is file $i" > "$DIR/file$i.txt"

    if [ $? -ne 0 ]; then
        echo "Error creating file$i.txt"
        exit 1
    fi
done

# Call child script
./child.sh "$DIR"

if [ $? -ne 0 ]; then
    echo "Child script failed."
    exit 1
fi

echo "Parent script completed successfully."