#!/usr/bin/env ruby -w
# wmtitle.rb
# Author: Andy Bettisworth
# Created At: 2014 1111 205534
# Modified At: 2014 1111 205534
# Description: set the current window's title

if ARGV.count > 0
  `wmctrl -r :SELECT: -N "#{ARGV.join(' ')}"`
else
  STDERR.puts 'USAGE: wmtitle.rb TITLE'
  exit 1
end
