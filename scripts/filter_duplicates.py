#!/usr/bin/python
import sys

#read file and store each line in a hashSet
def load_packages(filename):
    #read file
    f = open(filename,"r")
    lines = f.readlines()
    return set(lines)

packages = load_packages(sys.argv[1])
popular = load_packages(sys.argv[2])

for package in packages:
    if package not in popular:
        print(package,end='')


