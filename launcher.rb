#!/usr/bin/env ruby -w
# launcher.rb
# Author: Andy Bettisworth
# Description: Manage launchers

require 'optparse'

class LauncherManager
  TODO_PATH = "#{ENV['HOME']}/.sync/.todo"

  attr_accessor :project
  attr_accessor :project_path

  def initialize
    @project = File.basename(Dir.getwd).downcase.gsub(' ', '_')
    @project_path = "#{TODO_PATH}/#{@project}"
  end

  def toggle
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = 'USAGE: launcher [options]'

  opts.on('-t PROJECT', '--toggle PROJECT', 'Toggle launcher for project') do |project|
    options[:toggle] = project
  end
end
option_parser.parse!

mgmt = LauncherManager.new

if options[:toggle]
  mgmt.toggle(options[:toggle])
  exit
end

puts option_parser
