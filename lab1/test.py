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
tests = [test[0:-4] for test in os.listdir("tests/") if test[-4:]=='.cpp']
tests.sort()


def runtest(test):
    try:
        subprocess.check_output('clang++ -std=c++14 -Wall -o ./bin ./tests/'+test+'.cpp', shell=True)
        subprocess.check_output('./bin', timeout=15)
        subprocess.call('rm ./bin', shell=True)
        return True
    except:
        print('Test '+test+' failed.')
        subprocess.call('rm ./bin', shell=True)
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

