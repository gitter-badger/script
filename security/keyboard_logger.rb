#!/usr/bin/ruby -w
# keyboard_logger.rb
# Author: Andy Bettisworth
# Description: Keyboard event logger

require 'rubygems'
require 'libdevinput'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'security/security'

module Security
  class Keylogger
    include Admin
  end
end

if __FILE__ == $PROGRAM_NAME
  include Security

  dev = DevInput.new '/dev/input/event5'
  log = File.open('keyboard_events.log', 'a')
  dev.each do |event|
    log.write("got event #{event}\n")
  end
end
