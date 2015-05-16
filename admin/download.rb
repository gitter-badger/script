#!/usr/bin/env ruby
# download.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 221014
# Modified At: 2015 0513 221014
# Description: Manage Downloads

require 'optparse'

module Admin
  class Download
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: download [options] REGEXP"

    opts.on('-f', '--flush', 'Flush all downloads') do
      options[:flush] = true
    end

    opts.on('-p', '--pop', 'Move most recent download to desktop') do
      options[:pop] = true
    end

    opts.on('--list', 'List matching downloads') do
      options[:list] = true
    end

    opts.on('--fetch', 'Fetch matching downloads') do
      options[:fetch] = true
    end
  end
  option_parser.parse!

  puts option_parser

  # > download --flush
  # > download --pop
  # > download --list
  # > download --fetch REGEXP
end
