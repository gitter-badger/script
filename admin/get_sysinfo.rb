#!/usr/bin/ruby -w
# get_sysinfo.rb
# Author: Andy Bettisworth
# Description: Get current system information (linux-only) using proc

require_relative 'admin'

if __FILE__ == $PROGRAM_NAME
  proc_paths = Dir['/proc/**'].select { |dir| /\d+/.match(dir) }
  init_status = File.open(proc_paths[0] + '/status').read
  puts init_status
end
