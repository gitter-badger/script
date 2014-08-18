#!/usr/bin/ruby -w
# log_keyboard_events.rb
# Author: Andy Bettisworth
# Description: Keyboard event logger

## NOTE be sure to use `sudo` for sudoer priviledges

require 'rubygems'
require 'libdevinput'

dev = DevInput.new "/dev/input/event5"
log = File.open('keyboard_events.log', 'a')
dev.each do |event|
  log.write("got event #{event}\n")
end
