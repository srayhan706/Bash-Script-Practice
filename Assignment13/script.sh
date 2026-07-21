#!/bin/bash

extract_accounts() {

    local account_file=$1
    local age_file=$2
    local seq=1
    while IFS=',' read -r account age city state || [ -n "$account" ]
    do
        if grep -qx "$age" "$age_file"; then

            file="${account}_${seq}.txt"

            echo "${account}|${age}|${city}|${state}" > "$file"

            echo "Created $file"

            ((seq++))
        fi

    done < "$account_file"
}

create_zip() {

    zip age_filtered.zip *.txt >/dev/null

    echo "Created age_filtered.zip"
}

main() {

    if [ $# -ne 2 ]; then
        echo "Usage: $0 accounts.txt ages.txt"
        exit 1
    fi

    account_file=$1
    age_file=$2

    if [ ! -f "$account_file" ]; then
        echo "Account file not found."
        exit 1
    fi

    if [ ! -f "$age_file" ]; then
        echo "Age file not found."
        exit 1
    fi

    extract_accounts "$account_file" "$age_file"

    create_zip
}

main "$@"