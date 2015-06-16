#!/usr/bin/env python
# django_test.py
# Author: Andy Bettisworth
# Created At: 2015 0616 121928
# Modified At: 2015 0616 121928
# Description: run tests and determine coverage for any django project

import argparse
import os
import re

parser = argparse.ArgumentParser(description='django project testing tool')
parser.add_argument("-m", "--models",
    help="run model doctests",
    action="store_true")
parser.add_argument("PROJECT", help="provide django project", nargs='?')
args = parser.parse_args()

if not args.PROJECT:
    args.PROJECT = '.'

if args.models:
    try:
        model_modules = []
        models_re = re.compile(r'^models.py$', re.IGNORECASE)
        for root, dirnames, filenames in os.walk(args.PROJECT):
            for name in filenames:
                if models_re.match(name):
                    model_modules.append(os.path.join(root, name))
        # >   associate any doctests with a model
        # >   generate any errors
        # >   generate coverage
    except:
        pass
