#!/usr/bin/env ruby
# security.rb
# Author: Andy Bettisworth
# Created At: 2015 0620 210536
# Modified At: 2015 0620 210536
# Description: system security module

module Security
  STATIC_DIR = [
    '/boot',
    '/sbin',
    '/bin',
    '/usr/sbin',
    '/usr/bin',
    '/usr/lib',
    '/usr/local/bin',
    '/usr/local/lib'
  ]
end
