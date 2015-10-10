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

  remote = ARGV.first if ARGV.first
  remote ||= 'upstream'
  puts "Syncing with #{remote} repository..."
  system('git checkout master')
  system("git pull #{remote} master")
  system('git push origin master')
  system('git branch -D annex')
  system('git checkout -b annex')
end
