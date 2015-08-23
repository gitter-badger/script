#!/usr/bin/env ruby -w
# project.rb
# Author: Andy Bettisworth
# Description: Manage local projects

require_relative 'project'

if __FILE__ == $PROGRAM_NAME
  include Project
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: project [options] PROJECT'

    opts.on('-l [REGXP]', '--list [REGXP]', 'List all matching projects') do |regexp|
      options[:list] = true
      options[:list_pattern] = regexp
    end

    opts.on('-f', '--fetch PROJECT', 'Copy matching project(s) to Desktop') do |project|
      options[:fetch] = project
    end

    opts.on('--clean', 'Move project(s) off Desktop') do
      options[:clean] = true
    end
  end
  option_parser.parse!

  mgmt = ProjectManager.new

  if options[:list]
    mgmt.list(options[:list_pattern])
    exit 0
  elsif options[:fetch]
    mgmt.fetch(options[:fetch])
    exit 0
  elsif options[:clean]
    mgmt.clean
    exit 0
  end

  puts option_parser
  exit 1
end
