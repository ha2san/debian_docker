#!/bin/bash

#parse ldd output to get the libraries

#parse arguments
#if no arguments are given, print usage
if [ $# -eq 0 ]; then
    echo "Usage: $0 [MODE] <executable> [<executable> ...]"
    echo "  MODE:  -f: list library filename"
    exit 1
fi

#if argument is -f, then parse the filename in ldd output
if [ $1 = "-f" ]; then
    for i in "${@:2}"; do
        ldd $i | grep "=>" | awk '{print $3}' | tr '\n' ' '
    done
else
    #parse the library name (doesnt work well at the moment, prefer using -f)
    for i in "$@"; do
        ldd $i | grep "lib[^/]*\.so.*" | \
            sed 's/^.*lib\(.*\)\.so.*$/\1/' | \
            sed 's/^/-l/' | \
            tr '\n' ' '
        done
fi

