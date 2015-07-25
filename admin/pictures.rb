#!/usr/bin/env ruby
# pictures.rb
# Author: Andy Bettisworth
# Created At: 2015 0725 121329
# Modified At: 2015 0725 121329
# Description: symbolic link to picture.rb script

require_relative 'admin'

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: picture [options] FILE'

    opts.on('-l', '--list [REGEXP]', 'List matching picture(s)') do |regexp|
      options[:list] = true
      options[:list_regexp] = regexp
    end

    opts.on('-f', '--fetch', 'Copy matching picture(s) to ~/Desktop') do
      options[:fetch] = true
    end

    opts.on('-o', '--open', 'Open matching picture(s)') do
      options[:open] = true
    end

    opts.on('-i', '--info FILE', 'Show picture information') do |picture|
      options[:info] = picture
    end

    opts.on('--log', 'Show ~/Pictures log') do
      options[:log] = true
    end
  end
  option_parser.parse!

  picture_mgr = Picture.new

  if options[:list]
    picture_mgr.list(options[:list_regexp])
  elsif options[:fetch]
    picture_mgr.fetch(ARGV)
  else
    puts option_parser
    exit 1
  end
end
