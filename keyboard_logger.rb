#!/usr/bin/ruby -w
# keyboard_logger.rb
# Author: Andy Bettisworth
# Description: Keyboard event logger

require 'rubygems'
require 'libdevinput'

if __FILE__ == $0
  dev = DevInput.new "/dev/input/event5"
  log = File.open('keyboard_events.log', 'a')
  dev.each do |event|
    log.write("got event #{event}\n")
  end
end
