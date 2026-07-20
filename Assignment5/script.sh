#!/bin/bash

if [ $# -eq 1 ]; then
    input="$1"
else
    read -p "Entert input file path: " input
fi

if [ ! -f "$input" ];then
    echo "Error: File Not found."
    exit 1
fi

count=1
zipcnt=1

files=()

while IFS= read -r line
do 
    file="rayhan${count}.txt"
    echo "$line" > "$file"
    files+=("$file")

    if(( count % 5 == 0 ));then
        zip "chunk${zipcnt}.zip" "${files[@]}"
        files=()
        ((zipcnt++))
    fi

    ((count++))
done < "$input"

if [ ${#files[@]} -gt 0 ]; then
    zip "chunk${zipcnt}.zip" "${files[@]}"
fi

echo "Completed Successfully!"
