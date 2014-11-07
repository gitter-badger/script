#!/usr/bin/env ruby -w
# enforce-80char.rb
# Author: Andy Bettisworth
# Created At: 2014 1106 120459
# Modified At: 2014 1106 120459
# Description: automatically will add newlines to lines extending beyond 80 characters


if __FILE__ == $0
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "USAGE: enforce-80char [options] FILE"
  end
  option_parser.parse!

  if options[:quiet]
    puts 'success'
  else
    option_parser
  end
end
