#!/usr/bin/env python
# printable.py
# Author: Andy Bettisworth
# Created At: 2014 1107 144005
# Modified At: 2014 1107 144005
# Description: Removes any character from string that is not printable by python

if __name__ == '__main__':
    import sys
    import string

    if len(sys.argv) == 2:
        print filter(lambda x: x in string.printable, sys.argv[1])
    else:
        print 'USAGE: printable.py STRING'
