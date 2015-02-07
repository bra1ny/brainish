#!/usr/bin/env bash
# Illusion list_file_1(list_file) begins
list_file_1__file_list=$(ls .)
# Illusion list_file_1(list_file) ends
# Illusion for_each_1(for_each) begins
for for_each_1__iterator in $${list_file_1__file_list}; do
    # Illusion print_1(print) begins
    # echo "There is a file: "
    # Illusion print_1(print) ends
    # Illusion print_1(print) begins
    echo ${for_each_1__iterator}
    # Illusion print_1(print) ends
done;
# Illusion for_each_1(for_each) ends
