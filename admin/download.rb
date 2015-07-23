#!/usr/bin/env ruby
# download.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 221014
# Modified At: 2015 0513 221014
# Description: Manage ~/Downloads

require_relative 'admin'

module Admin
  # manage all local ~/Downloads
  class Download
  end
end

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

    opts.on('-p', '--pop [COUNT]', 'Move most recent download to desktop') do |count|
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

  puts option_parser
  exit 1
end
