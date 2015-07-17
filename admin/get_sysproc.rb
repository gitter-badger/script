#!/usr/bin/ruby -w
# get_sysproc.rb
# Author: Andy Bettisworth
# Description: Get current system information (linux-only) using proc

require_relative 'admin'

if __FILE__ == $PROGRAM_NAME
  proc_paths = Dir['/proc/**'].select { |dir| /\d+/.match(dir) }
  init_status = File.open(proc_paths[1] + '/status').read
  status_variables = init_status.split(/\n/)
  status_variables.each do |var|
     key_pair = var.split(':')
     puts "key: #{key_pair[0]} value: #{key_pair[1]}"
  end
end
