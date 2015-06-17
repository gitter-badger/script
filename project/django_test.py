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

from django.apps import apps
from django.core.management import call_command
from django.conf import settings
from django.db import connections

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='django project testing tool')
    parser.add_argument("-m", "--models", help="run model doctests", action="store_true")
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
        print 'Loading %s...' % project_settings
        sys.path.append(project_abs)
        os.chdir(project_abs)
        os.environ.setdefault("DJANGO_SETTINGS_MODULE", project_settings)
        django.setup()
    except Exception as e:
        print 'ERROR: %s' % e
        sys.exit(1)

    try:
        print 'Connecting %s...' % test_db_name
        connections.databases[test_db_name] = {
            'ENGINE':   'django.contrib.gis.db.backends.postgis',
            'NAME':     test_db_name,
            'USER':     'testuser',
            'PASSWORD': 'testpassword',
            'HOST':     'localhost'
        }
        conn = connections[test_db_name]
        conn_test = conn.cursor()
    except Exception as e:
        print 'ERROR: %s' % e
        os.system('createuser -P -s testuser')
        os.system('createdb %s -O testuser' % test_db_name)
        sys.exit(1)

    try:
        print 'Syncing models...'
        call_command('migrate', database=test_db_name)
    except Exception as e:
        print 'ERROR %s' % e
        sys.exit(1)

    try:
        all_models  = apps.get_models()
        model_count = len(all_models)

        model_modules = []
        models_re = re.compile(r'^models.py$', re.IGNORECASE)
        for root, dirnames, filenames in os.walk('.'):
            for name in filenames:
                if models_re.match(name):
                    model_modules.append(os.path.join(root, name))

        total_tests = 0
        total_failure = 0
        for module_pathname in model_modules:
            print ''
            print 'Testing %s...' % module_pathname
            failure_count, test_count = doctest.testfile(
                filename=module_pathname,
                optionflags=doctest.REPORT_ONLY_FIRST_FAILURE)
            total_tests += test_count
            total_failure += failure_count

        coverage = int(round(float(total_failure) / float(total_tests), 2) * 100)

        print ''
        print "%s%% model coverage (%s / %s)" % (coverage, total_failure, total_tests)
    except Exception as e:
        pass
