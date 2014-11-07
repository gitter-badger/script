#!/usr/bin/env ruby -w
# django-dependencies.rb
# Author: Andy Bettisworth
# Created At: 2014 1106 124502
# Modified At: 2014 1106 124502
# Description: resolves dependencies required within the management commands of a django project

class DjangoDependencies
  def start
    cmds = get_cmds

    cmds.each do |cmd,mod|
      `./manage.py --verbosity 0 #{cmd}`

      # if $? == 0
      #   puts "Success: #{cmd}"
      # else
      #   puts 'rescue'
      #   # missing_lib = /No\smodule\snamed\s(?<module>.*?)\n/.match(result)
      #   # puts missing_lib[0][:module]
      #     # > try install module
      # end
    end
  end

  def get_cmds
    mgmt_arr = `./manage.py`.split("\n")[21..-1]
    cmds = {}
    app_module = ''

    mgmt_arr.each do |e|
      app_module = e.gsub("\[", '').gsub("\]", '') if /\[.*?\]/.match(e)
      unless /\[.*?\]/.match(e)
        cmds[e.strip] = app_module
      end
    end

    cmds
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
