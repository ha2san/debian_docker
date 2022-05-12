#!/bin/bash

search="implemented-in::c++"
output="ListPack_c++"
rm -f $output 

#get the 100 first packages
j=0
for i in $(cat $1); do
    if [ $j -gt 100 ]; then
        break
    fi

    if [[ $(apt show $i | grep $search) ]]; then
        j=$((j+1))
        echo $i >> $output 
    fi
done

