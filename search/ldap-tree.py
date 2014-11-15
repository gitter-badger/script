#!/usr/bin/env python
# ldap-tree.py
# Author: Andy Bettisworth
# Created At: 2014 1107 145652
# Modified At: 2014 1107 145652
# Description: map an LDAP directory structure

if __name__ == '__main__':
    import sys
    import ldap

    if len(sys.argv) == 6:
        uri      = sys.argv[1]
        user     = sys.argv[2]
        password = sys.argv[3]
        dn       = sys.argv[4]
        lookup   = sys.argv[5]

        print 'uri:      ' + uri
        print 'user:     ' + user
        print 'password: ' + password
        print 'dn:       ' + dn
        print 'lookup:   ' + lookup

        print 'Attempting LDAP binding...'

        conn   = ldap.initialize(uri)
        conn.simple_bind_s(user, password)

        result = conn.search_s(dn,ldap.SCOPE_SUBTREE,lookup)
        print result[0][1].keys()
    else:
        print 'USAGE: ldap-tree.py URI USER PASS DN LOOKUP'
