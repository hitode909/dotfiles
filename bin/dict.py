#!/usr/bin/python2.5

import sys
from DictionaryServices import *

def main():
    word = sys.argv[1].decode('utf-8')
    result = DCSCopyTextDefinition(None, word, (0, len(word)))
    if result:
        print result.encode('utf-8')
    else:
        print "nil"

if __name__ == '__main__':
    main()
