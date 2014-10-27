#!/usr/bin/env python
# portscan.py
# Author: Andy Bettisworth
# Description: Basic port scanner

import sys, socket

## > pass in target ip
## > pass in port range

for port in range(0,1000):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    result = sock.connect_ex( ("117.23.85.11", port) )
    if result == 0:
        print "Port " + str(port) + " Open."
    sock.close()
