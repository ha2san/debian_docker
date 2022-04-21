#!/bin/bash
pkg="$1"

echo "Docker started for $pkg"
cd /home/retro
#get source code for compiling with nostrip option
apt-get build-dep $pkg -y
DEB_BUILD_OPTIONS="nostrip noopt" apt -b source $pkg 
dpkg -i *amd64.deb 

for i in  $(dpkg -L $pkg | \
    xargs -I {} file {} | \
    grep "executable, x86-64" | \
    awk -F ":" '{print $1}'); do

    log0="$(basename $i).log"
    $i --help  &> $log0; 

    asm=${i}_instrumented.asm
    logR=$(basename $i)_retrowrite.log
    retrowrite $(which $i) $asm &> $logR;

    retro_binary=${i}_instrumented_binary
    clang++ $asm -o $retro_binary $(/etc/flib -f $i) 

    log1=$(basename $i)_binary_retro.log
    $retro_binary --help &> $log1;

    #if last command was successful, then add the binary name to the list
    if [ $? -eq 0 ]; then
        echo $i >> no_diff_list.log 
    else 
        #compare with the log of the original binary
        diff $log0 $log1 &> /dev/null
        if [ $? -eq 0 ]; then
            echo $i >> no_diff_list.log 
        else
            echo $i >> diff_list.log
        fi
    fi

    #maybe the log are the same but only the executable name change
    #change every occurence of binary name to match the original executable 
    #original="$(basename $i)"
    #instrumented="$(basename $retro_binary)"
    #sed -i "s%$instrumented%$original%g" $log1
    
    ##if custom and orinal are different, add filename to list
    #if ! diff $log0 $log1 > /dev/null ; then
    #    echo $i >> diff_list.log
    #else 
    #    echo $i >> no_diff_list.log
    #fi
    
    #delete everything but the log files
    find .  -not -name '*.log' -exec rm -rf {} \;

done
