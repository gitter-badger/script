#!/usr/bin/env ruby -w
# gitcommit.rb
# Author: Andy Bettisworth
# Description: Simple bundling of commands to execute a git commit

if __FILE__ == $0
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
