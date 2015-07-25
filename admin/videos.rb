#!/usr/bin/env ruby
# videos.rb
# Author: Andy Bettisworth
# Created At: 2015 0725 121255
# Modified At: 2015 0725 121255
# Description: symbolic link to video.rb script

require_relative 'video'

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: video [options] FILE'

    opts.on('-l', '--list [REGEXP]', 'List matching video(s)') do |regexp|
      options[:list] = true
      options[:list_regexp] = regexp
    end

    opts.on('-f', '--fetch', 'Copy matching video(s) to ~/Desktop') do
      options[:fetch] = true
    end

    opts.on('-o', '--open', 'Open matching video(s)') do
      options[:open] = true
    end

    opts.on('-i', '--info FILE', 'Show video information') do |video|
      options[:info] = video
    end

    opts.on('--log', 'Show ~/Videos log') do
      options[:log] = true
    end
  end
  option_parser.parse!

  video_mgr = Video.new

  if options[:list]
    video_mgr.list(options[:list_regexp])
  elsif options[:fetch]
    video_mgr.fetch(ARGV)
  else
    puts option_parser
    exit 1
  end
end
