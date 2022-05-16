#!/bin/bash

search="implemented-in::c++"
output="ListPack_c++"
rm -f $output 

for i in $(cat $1); do

    if [[ $(apt show $i | grep $search) ]]; then
        echo $i >> $output 
    fi
done

