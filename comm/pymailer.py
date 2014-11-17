#!/usr/bin/env python
# sendmail.py
# Author: Andy Bettisworth
# Description: Simple mailer

import MySQLdb
import smtplib
import commands
import time
import os
from email.MIMEMultipart import MIMEMultipart
from email.MIMEBase import MIMEBase
from email.MIMEText import MIMEText
from email.Utils import COMMASPACE, formatdate
from email import Encoders
import urllib2

## > abstract addresses (input)
## > abstract mail server (input)

def send_mail(server,from_address,to_address,subject):
  msg            = MIMEMultipart()
  msg['From']    = from_address
  msg['To']      = to_address
  msg['Date']    = formatdate(localtime=True)
  msg['Subject'] = subject
  body           = """
EMAIL CONTENT GOES IN HERE
"""
  msg.attach(MIMEText(body))
  smtp = smtplib.SMTP(server)
  smtp.sendmail(from_address, to_address, msg.as_string())
  smtp.close()

server = ""
from_address = "John Smith <john.smith@example.com>"
subject = "IT Network Services Broadcast"

addresses = ["John Doe <John.Doe@targetdomain.com>"," Jane Doe <Jane.Doe@targetdomain.com >"]

for to_address in addresses:
  print "[*] Sending Mail To "+to_address
  send_mail(server,from_address,to_address,subject)
  time.sleep(10)
