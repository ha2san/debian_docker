#!/bin/sh
exception="exceptions.log"

no_exception="no_exceptions.log"

size="size.log"


result="../exception_result"

#create new directory "result", if directory already exists, it will be deleted
rm -rf $result 
mkdir $result 

#look in each directory for the file and append it to diff.log
for i in `ls -d exceptions/*/`
do
    #look if file exists
    if [ -f $exception ]
    then
        #append file to diff.log
        cat $exception >> $result/$exception
    fi

    if [ -f $no_exception ]
    then
        cat $no_exception >> $result/$no_exception
    fi

    if [ -f $size ]
    then
        cat $size >> $result/$size
    fi

done
