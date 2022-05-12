#!/bin/sh

#given a list of popular packages, filter the name and output it in another file
lines=$(cat $1)
filtered_list=popular_filtered_list.txt

i=0
#for each line, get the names
while read -r line
do
    name=$(echo $line | awk '{print $2}')
    echo $name >> $filtered_list
done <$1


