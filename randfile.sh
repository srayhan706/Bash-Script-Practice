#!/bin/bash

mkdir -p random_files

for i in {1..5};
do
    touch "random_files/file_$RANDOM.txt"
done

ls random_files | while read file;
                    do
                        echo "$file"
                    done