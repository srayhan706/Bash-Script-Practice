#!/bin/bash

INPUT_FILE=$1

process_file() {

    seq=1

    while IFS=',' read -r name age
    do
        filename="${name}_${seq}.txt"

        echo "${name}|${age}" > "$filename"

        seq=$((seq+1))

    done < "$INPUT_FILE"

}

process_file