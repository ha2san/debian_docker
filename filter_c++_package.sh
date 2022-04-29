#!/bin/sh

for i in $(cat ListPack); do
    apt show $i | grep implemented-in::c++ &> /dev/null
    if [ $? -eq 0 ]; then
        echo $i >> ListPack_c++.log
    fi
done
