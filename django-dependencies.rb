#!/usr/bin/env ruby -w
# django-dependencies.rb
# Author: Andy Bettisworth
# Created At: 2014 1106 124502
# Modified At: 2014 1106 124502
# Description: resolves dependencies required within the management commands of a django project

class DjangoDependencies
  def start
    mgmt_arr = `./manage.py`.split("\n")[21..-1]
    cmds = {}
    mgmt_arr.each do |e|
      puts e if /\[.*?\]/.match(e)
    end
    # > get list of management cmds [Array]
    # > loop cmds
      # > try execute
      # > rescue 'no module named'
        # > try install module
  end
end

if __FILE__ == $0
  require 'optparse'

  option_parser = OptionParser.new do |opts|
    opts.banner = <<-MSG
USAGE:    django-dependencies
REQUIRES: current directory is a Django project
    MSG
  end
  option_parser.parse!

  getter = DjangoDependencies.new

  if File.exist?('./manage.py')
    getter.start
  else
    puts option_parser
  end
end
