#!/bin/sh
fdiff="diff_error.log"

ndiff="no_error.log"

sdiff="same_exit_code.log"

result="../result"

#create new directory "result", if directory already exists, it will be deleted
rm -rf $result 
mkdir $result 

#look in each directory for the file and append it to diff.log
for i in `ls -d repo/*/`
do
    #look if file exists
    if [ -f $i$fdiff ]
    then
        #append file to diff.log
        cat $i$fdiff >> $result/$fdiff

    fi

    if [ -f $i$ndiff ]
    then
        cat $i$ndiff >> $result/$ndiff

    fi
    if [ -f $i$sdiff ]
    then
        cat $i$sdiff >> $result/$sdiff
    fi

done

#count the number of lines in diff_list.log
diff_lines=`wc -l $result/$fdiff | cut -d " " -f 1`
#count the number of lines in no_diff_list.log
no_diff_lines=`wc -l $result/$ndiff | cut -d " " -f 1`
same_errors_lines=`wc -l $result/$sdiff | cut -d " " -f 1`
echo "Number of lines in $fdiff : $diff_lines"
echo "Number of lines in $ndiff: $no_diff_lines"
echo "Number of lines in $sdiff: $same_errors_lines"
