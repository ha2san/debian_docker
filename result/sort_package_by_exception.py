#!/bin/python


def file_to_set(file_name):
    """
    Read a file and return a set of its lines.
    """
    file_set = set()
    with open(file_name, 'r') as f:
        for line in f:
            file_set.add(line.strip())
    return file_set


exception_set = file_to_set('exceptions.log')
no_exception_set = file_to_set('no_exceptions.log')

no_error_set = file_to_set('no_error.log')
compilation_error_set = file_to_set('compilation_error.txt')
segfault_set = file_to_set('segfault_error.txt')

exception_compilation_error_set = exception_set.intersection(
    compilation_error_set)
exception_no_error_set = exception_set.intersection(no_error_set)
exception_segfault_set = exception_set.intersection(segfault_set)

no_exception_compilation_error_set = no_exception_set.intersection(
    compilation_error_set)
no_exception_no_error_set = no_exception_set.intersection(no_error_set)
no_exception_segfault_set = no_exception_set.intersection(segfault_set)

#print size of each set
print("exception_compilation_error_set:", len(exception_compilation_error_set))
print("exception_no_error_set:", len(exception_no_error_set))
print("exception_segfault_set:", len(exception_segfault_set))
print("no_exception_compilation_error_set:",
      len(no_exception_compilation_error_set))
print("no_exception_no_error_set:", len(no_exception_no_error_set))
print("no_exception_segfault_set:", len(no_exception_segfault_set))
