#!/usr/bin/env ruby -w
# django-dependencies.rb
# Author: Andy Bettisworth
# Created At: 2014 1106 124502
# Modified At: 2014 1106 124502
# Description: resolves dependencies required within the management commands of a django project


if __FILE__ == $0
  require 'optparse'

  option_parser = OptionParser.new do |opts|
    opts.banner = <<-MSG
USAGE: django-dependencies
REQUIRES: current directory is a Django project
    MSG
  end
  option_parser.parse!

  puts option_parser
end
