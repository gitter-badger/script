#!/usr/bin/env python
# epub2mobi.py
# Author: Juan Reyero, Andy Bettisworth
# Description: Convert books formatted epub to mobi (kindle usage)

import os

def epub2mobi(from_dir, to_dir):
    """
    Look for .epub files in from_dir, convert them to .mobi and store
    them in the flat directory to_dir unless their path includes any string
    present in the list ignore_if.

    Requires ebook-convert, coming from calibre (http://calibre-ebook.com).
    """

    print "Converting EPUB to MOBI..."
    print "from_dir:  %s" % from_dir
    print "to_dir:    %s" % to_dir
    print ""

    if not os.path.exists(to_dir):
        os.makedirs(to_dir)

    for root, dirs, files in os.walk(from_dir):
        for fl in files:
            name, extension = os.path.splitext(fl)
            if extension == '.epub':
                mobi = os.path.join(root, name + '.mobi')
                # mobi = os.path.join(to_dir, name + '.mobi')
                if not os.path.exists(mobi):
                    os.system("ebook-convert '%s' '%s'" % (os.path.join(root, fl), mobi))

if __name__ == '__main__':
    import sys
    from_dir, to_dir = '.', '.'
    if len(sys.argv) > 1:  from_dir = sys.argv[1]
    if len(sys.argv) == 3: to_dir = sys.argv[2]
    epub2mobi(from_dir, to_dir)
