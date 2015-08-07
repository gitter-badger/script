#!/usr/bin/env ruby -w
# gitcommit.rb
# Author: Andy Bettisworth
# Description: Simple bundling of commands to execute a git commit

require_relative 'project'

module Project
end

if __FILE__ == $PROGRAM_NAME
  include Project

  if File.exist?('.git')
    puts "Creating a git commit within #{Dir.pwd}"
    message = gets.chomp until message
    system <<-CMD
      git add -A
      git commit -m '#{message}'
    CMD
  else
    raise "No git repository found at '#{Dir.pwd}'"
  end
end
