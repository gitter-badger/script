#!/usr/bin/ruby -w
# pg_pid.rb
# Author: Andy Bettisworth
# Description: GET all postgresql pid

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Admin
end

if __FILE__ == $PROGRAM_NAME
  # > TODO use PGConfig.new to get 'externnal_pid_file'
  pid_file = `cat /var/run/postgresql/9.3-main.pid`
  pid_list = pid_file.split("\n")
  pid_list.map! { |pid| pid.to_i }
  puts pid_list
end
