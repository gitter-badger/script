#!/usr/bin/env ruby
# download.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 221014
# Modified At: 2015 0513 221014
# Description: Manage Downloads

## Delete all files in download directory, password to confirm
download --flush

## Move most recent file to Desktop
download --pop

## List downloads sort by most recent
download --list

## Fetch downloads that match regular expression
download --fetch REGEXP
