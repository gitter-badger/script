#!/usr/bin/env ruby -w
# gitcommit.rb
# Author: Andy Bettisworth
# Description: Simple bundling of commands to execute a git commit

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'project/project'

if __FILE__ == $PROGRAM_NAME
  include Project

  if File.exist?('.git')
    puts "Creating a git commit within #{Dir.pwd}"
    message = gets.chomp until message
    system('git add -A')
    system('git commit -m "' + message + '"')
  else
    raise "No git repository found at '#{Dir.pwd}'"
  end
end
