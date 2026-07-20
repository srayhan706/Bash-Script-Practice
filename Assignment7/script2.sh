#!/bin/bash

read -p "Enter input file: " input

grep '^200\|^400' "$input" |
sed 's/~/|/g' |
awk -F'|' '
/^200/{
    acc=$0
}
/^400/{
    print acc "|" $2
}'>output.txt