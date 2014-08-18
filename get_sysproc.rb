#!/usr/bin/ruby -w
# get_sysproc.rb
# Author: Andy Bettisworth
# Description: Get current system information (linux-only) using proc
# NOTE proc is a 'process information pseudo-file system'

## > print to command-line

# GET list of processes /proc/<proc_id>
proc_paths = Dir['/proc/**'].select { |dir| /\d+/.match(dir) }

# GET proc status
init_status = File.open(proc_paths[1] + '/status').read
status_variables = init_status.split(/\n/)
status_variables.each do |var|
   key_pair = var.split(':')
   puts "key: #{key_pair[0]} value: #{key_pair[1]}"
end

# CREATE YAML file
require 'yaml'
# puts YAML.dump(init_status)

## > Log in YAML or PostgreSQL

