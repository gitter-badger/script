#!/usr/bin/env ruby
# downloads.rb
# Author: Andy Bettisworth
# Created At: 2015 0725 121352
# Modified At: 2015 0725 121352
# Description: symbolic link to download.rb script

require_relative 'download'

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: download [options] FILE'

    opts.on('-l', '--list [REGEXP]', 'List matching download(s)') do |regexp|
      options[:list] = true
      options[:list_regexp] = regexp
    end

    opts.on('-f', '--fetch', 'Copy matching download(s) to ~/Desktop') do
      options[:fetch] = true
    end

    opts.on('-o', '--open', 'Open matching download(s)') do
      options[:open] = true
    end

    opts.on('-i', '--info FILE', 'Show download information') do |download|
      options[:info] = download
    end

    opts.on('-p', '--pop [COUNT]', 'Move most recent download to ~/Desktop') do |count|
      options[:pop] = true
      options[:pop_count] = count
    end

    opts.on('--flush', 'Flush/Delete all downloads') do
      options[:flush] = true
    end

    opts.on('--log', 'Show ~/Downloads log') do
      options[:log] = true
    end
  end
  option_parser.parse!

  download_mgr = Download.new

  if options[:list]
    download_mgr.list(options[:list_regexp])
  elsif options[:fetch]
    download_mgr.fetch(ARGV)
  else
    puts option_parser
    exit 1
  end
end
