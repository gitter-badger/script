#!/usr/bin/ruby -w
# keyboard_logger.rb
# Author: Andy Bettisworth
# Description: Keyboard event logger

require 'rubygems'
require 'libdevinput'

require_relative 'security'

module Security
end

if __FILE__ == $PROGRAM_NAME
  include Security

  dev = DevInput.new '/dev/input/event5'
  log = File.open('keyboard_events.log', 'a')
  dev.each do |event|
    log.write("got event #{event}\n")
  end
end
