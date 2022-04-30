#!/bin/sh

for i in $(cat $1); do
    apt show $i | grep implemented-in::c++ &> /dev/null
    if [ $? -eq 0 ]; then
        echo $i >> ListPack_c++.log
    fi
done
