#!/usr/bin/ruby -w
# irb_spec.rb
# Author: Andy Bettisworth
# Description: A weak implementation of IRB

if __FILE__ == $0
  while true
    print 'cmd> '
    cmd = gets
    puts(eval(cmd))
  end
end
