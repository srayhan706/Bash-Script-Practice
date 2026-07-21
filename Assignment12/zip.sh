#!/bin/bash

create_zip() {

    files=(*_*.txt)

    total=${#files[@]}
    zipno=1

    for ((i=0;i<total;i+=3))
    do

        index="index.txt"
        > "$index"

        zipfiles=()

        for ((j=i;j<i+3 && j<total;j++))
        do

            file=${files[j]}

            zipfiles+=("$file")

            awk -F'|' '
            {
                split(FILENAME,a,"_")
                print $1 "," $2 "," FILENAME
            }
            ' "$file" >> "$index"

        done

        zip "accounts_${zipno}.zip" "${zipfiles[@]}" "$index"

        rm "$index"

        zipno=$((zipno+1))

    done

}

create_zip