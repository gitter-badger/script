#!/usr/bin/ruby -w
# get_sysinfo.rb
# Author: Andy Bettisworth
# Description: Get current system information (linux-only) using proc
# NOTE proc is a 'process information pseudo-file system'

## > print to command-line

# GET list of processes /proc/<proc_id>
proc_paths = Dir['/proc/**'].select { |dir| /\d+/.match(dir) }

# GET proc status
init_status = File.open(proc_paths[0] + '/status').read

# CREATE YAML file

## > Log in YAML or PostgreSQL

