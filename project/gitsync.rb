#!/usr/bin/env ruby
# gitsync.rb
# Author: Andy Bettisworth
# Created At: 2015 0916 091440
# Modified At: 2015 0916 091440
# Description: sync with upstream repo

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'project/project'

if __FILE__ == $PROGRAM_NAME
  include Project

  raise "No git repository found at '#{Dir.pwd}'" unless File.exist?('.git')
  `git ls-remote --exit-code upstream`
  raise 'No remote upstream.' unless $? == 0

  puts "Syncing with upstream repository..."
  # message = gets.chomp until message
  # system('git add -A')
  # system('git commit -m "' + message + '"')
end
