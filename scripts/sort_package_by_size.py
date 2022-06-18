#!/bin/python
from operator import itemgetter


def file_to_set(file_name,is_two_element=False):
    """
    Read a file and return a set of its lines.
    """
    file_set = set()
    if(is_two_element):
        file_set = list()
    with open(file_name, 'r') as f:
        for line in f:
            if(not is_two_element):
                file_set.add(line.strip())
            else:
                file_set.append(line.strip().split(' '))
    return file_set


sizes = file_to_set('size.log',True)


no_error_set = file_to_set('no_error.log')
compilation_error_set = file_to_set('compilation_error.txt')
segfault_set = file_to_set('segfault_error.txt')

list_size = 20

size_category = list()
for size in sizes:
    if(size[0] in no_error_set):
        size_category.append((size[0],int(size[1]),0))
    elif (size[0] in compilation_error_set):
        size_category.append((size[0],int(size[1]),1))
    elif (size[0] in segfault_set):
        size_category.append((size[0],int(size[1]),2))
    
size_category = sorted(size_category,key=itemgetter(1))

#separate size_category into ten lists
size_category_10 = list()
for i in range(list_size):
    size_category_10.append(list())

for i in range(len(size_category)):
    index = i / len(size_category) * list_size 
    size_category_10[int(index)].append(size_category[i])

#open three files to write for each category
no_error_file = open('Gno_error.txt','w')
compilation_file = open('Gcompilation_error.txt','w')
segfault_file = open('Gsegfault_error.txt','w')
size_categories_file = open('Gsize_categories.txt','w')

def humanbytes(B):
    """Return the given bytes as a human friendly KB, MB, GB, or TB string."""
    B = float(B)
    KB = float(1024)
    MB = float(KB ** 2) # 1,048,576
    GB = float(KB ** 3) # 1,073,741,824
    TB = float(KB ** 4) # 1,099,511,627,776

    if B < KB:
        return '{0} {1}'.format(B,'Bytes' if 0 == B > 1 else 'Byte')
    elif KB <= B < MB:
        return '{0:.2f} KB'.format(B / KB)
    elif MB <= B < GB:
        return '{0:.2f} MB'.format(B / MB)
    elif GB <= B < TB:
        return '{0:.2f} GB'.format(B / GB)
    elif TB <= B:
        return '{0:.2f} TB'.format(B / TB)


#for each list, count the number of each type of error
for i in range(list_size):
    compilation_error_count = 0
    segfault_error_count = 0
    no_error_count = 0
    for j in range(len(size_category_10[i])):
        if(size_category_10[i][j][2] == 0):
            no_error_count += 1
        elif(size_category_10[i][j][2] == 1):
            compilation_error_count += 1
        elif(size_category_10[i][j][2] == 2):
            segfault_error_count += 1
    if len(size_category_10[i]) != 0:
        size_min = size_category_10[i][0][1]
        size_max = size_category_10[i][-1][1]
        print(str(i)+': Size ' + str(size_min) + ' to '+ str(size_max) + ' No error: ' + str(no_error_count) + ' Compilation error: ' + str(compilation_error_count) + ' Segfault error: ' + str(segfault_error_count))
        #output to file
        #append to file
        no_error_file.write(str(no_error_count)+'\n')
        compilation_file.write(str(compilation_error_count)+'\n')
        segfault_file.write(str(segfault_error_count)+'\n')
        size_categories_file.write(humanbytes(size_min)+'-'+humanbytes(size_max)+'\n')






