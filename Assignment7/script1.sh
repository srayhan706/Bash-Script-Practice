#!/bin/bash

if [ $# -eq 1 ]; then
    input="$1"
else
    read -p "Enter input file: " input
fi

if [ ! -f "$input" ]; then
    echo "File not found!"
    exit 1
fi


awk ' BEGIN{
        FS="~" 
        OFS="|"
    } 
    /^200/{
        account= $1 OFS $2 OFS $4 OFS $5
    } /^400/{
        print account OFS $2
    }
    ' "$input" > accounts.txt
echo "Accounts saved to accounts.tx"