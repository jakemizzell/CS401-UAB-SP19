#!/usr/bin/python3
# #######################
#
# This file runs tests for this coding assignment.
# Read the file but do not modify.
#
# #######################


import os
import sys
import time
import subprocess


# e.g., tests == ["public0", "secret_test3", ...]
tests = (['public_sort_'+test[0:-4] for test in os.listdir("tests/") if test[-4:]=='.txt']
             + ['public_reverse_'+test[0:-4] for test in os.listdir("tests/") if test[-4:]=='.txt'])
tests.sort()


def readnumbers(filename):
    with open(filename, 'r') as fh:
        return list(map(lambda x:int(x),
                        (" ".join(fh.readlines()).replace("\r","").replace("\n","").replace("  "," ")).strip().split(" ")))

def runtest(test):
    try:
        srcname = './'+test.split('_')[1]+'.cpp'
        inputname = './tests/' + test.split('_')[2] + '.txt'
        subprocess.check_output('clang++ -std=c++14 -Wall -o ./bin '+srcname, shell=True)
        subprocess.check_output('./bin < '+inputname+' > out.txt', shell=True)
        innumbers = readnumbers(inputname)
        outnumbers = readnumbers('./out.txt')
        subprocess.call('rm ./out.txt', shell=True)
        subprocess.call('rm ./bin', shell=True)
        if srcname == "./sort.cpp" and list(sorted(innumbers)) == outnumbers:
            return True
        elif srcname == "./reverse.cpp" and list(reversed(innumbers)) == outnumbers:
            return True
        else:
            print('Test '+test+' failed.')
            return False
    except:
        print('Test '+test+' failed.')
        return False
    

if len(sys.argv) > 1 and str(sys.argv[1]) == "all":
    # Run all tests
    correct = 0
    for test in tests:
        if runtest(test): correct += 1
    if correct == len(tests):
        print("All %d out of %d tests passed! Write more?" % (correct,len(tests)))
        exit(0)
    else:
        print("%d out of %d tests passed" % (correct,len(tests)))
        exit(1)
elif len(sys.argv) > 1 and str(sys.argv[1]) == "list":
    print(", ".join(tests))
elif len(sys.argv) > 1 and str(sys.argv[1]) in tests:
    if runtest(str(sys.argv[1])):
        print("Test "+str(sys.argv[1])+" passed!")
        exit(0)
    else:
        exit(1)
else:
    print("""
Usage: $ python3 test.py all    --- Runs all tests
       $ python3 test.py list   --- Lists all tests by name
       $ python3 test.py name   --- Runs a specific test by name
To add your own tests, copy/paste a test in the tests/ folder and give
it a different name. Modify the file as appropriate for your test and
and be sure your test returns exit code 0/1 to indicate passing/failing.
""")

