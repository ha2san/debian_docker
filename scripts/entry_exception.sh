#!/bin/bash
pkg="$1"

echo "Docker started for $pkg"


cd /home/retro
timeout 3m apt install --no-install-recommends -y $pkg 

for i in  $(dpkg -L $pkg | \
    xargs -I {} file {} | \
    grep "executable, x86-64" | \
    awk -F ":" '{print $1}'); do

    echo "Running elfexceptions.py $i"
    log_size="size.log"
    response=$(/etc/elfexceptions.py $i) 

    size=$(stat -c %s $i)

    if [ "$response" == "yes" ]; then
        echo "Adding $i to exceptions.log"
        echo "$i" >> exceptions.log
        else 
        echo "Adding $i to no_exceptions.log"
        echo "$i" >> no_exceptions.log
    fi

    echo "$i $size" >> $log_size
    

echo "entrypoint script finished"
done
