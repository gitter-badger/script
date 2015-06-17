#!/usr/bin/env python
# django_test.py
# Author: Andy Bettisworth
# Created At: 2015 0616 121928
# Modified At: 2015 0616 121928
# Description: run tests and determine coverage for any django project

import argparse
import os
import sys
import re
import doctest
import django

from django.conf import settings
from django.db import connections

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='django project testing tool')
    parser.add_argument("-m", "--models",
        help="run model doctests",
        action="store_true")
    parser.add_argument("PROJECT", help="provide django project", nargs='?')
    args = parser.parse_args()

    if not args.PROJECT:
        args.PROJECT = '.'
    project_dir      = args.PROJECT
    project_abs      = os.path.abspath(args.PROJECT)
    project_name     = os.path.basename(project_abs).lower()
    project_settings = "%s.settings" % project_name
    test_db_name     = '%s_test' % project_name

    try:
        print 'Loading %s.settings ...' % project_name
        sys.path.insert(0, project_abs)
        os.environ.setdefault("DJANGO_SETTINGS_MODULE", project_settings)
        django.setup()
    except Exception as e:
        print 'ERROR: %s' % e

    try:
        print 'Connecting to %s...' % test_db_name
        connections.databases[test_db_name] = {
            'ENGINE':   'django.contrib.gis.db.backends.postgis',
            'NAME':     test_db_name,
            'USER':     'testuser',
            'PASSWORD': 'testpassword',
            'HOST':     'localhost'
        }
        connections.databases.ensure_defaults(test_db_name)
        conn = connections[test_db_name]
        print conn
    except Exception as e:
        print e
        os.system('createuser -P -s testuser')
        os.system('createdb %s -O testuser' % test_db_name)

    if args.models:
        try:
            model_modules = []
            models_re = re.compile(r'^models.py$', re.IGNORECASE)
            for root, dirnames, filenames in os.walk(args.PROJECT):
                for name in filenames:
                    if models_re.match(name):
                        model_modules.append(os.path.join(root, name))

            for module_pathname in model_modules:
                print 'Testing %s...' % module_pathname
                doctest.testfile(module_pathname)
        except:
            pass
