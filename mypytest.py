#!/usr/bin/env ruby -w
# mypytest.py
# Author: Andy Bettisworth
# Description: Execute a pytest assertion from command-line

import pytest

def test_the_obvious():
    assert True == True

if __name__ == '__main__':
    pytest.main()
