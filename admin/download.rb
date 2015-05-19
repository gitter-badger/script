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

  if ARGV.size > 0
    is_fetch = false

    if options[:fetch]
      is_fetch = true
    end

    admin_download = Admin::Download.new

    if options[:flush]
      # > download --flush
      admin_download.flush
    elsif options[:pop]
      # > download --pop
      admin_download.pop
    elsif options[:list]
      # > download --list
      admin_download.list
    else
      # > download --fetch REGEXP
      admin_download.fetch
    end
  end

  puts option_parser
  exit 1
end
