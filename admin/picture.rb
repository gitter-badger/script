#!/usr/bin/env ruby
# picture.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220924
# Modified At: 2015 0513 220924
# Description: Manage Pictures

require 'optparse'

module Admin
  class Picture
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: picture [options] DIR"

    opts.on('--depth DEPTH', 'Limit number of directory depth') do |depth|
      options[:depth] = depth
    end

    opts.on('-s', '--slideshow', 'Play the slideshow') do
      options[:slideshow] = true
    end

    opts.on('-f', '--fullscreen', 'Browse in fullscreen') do
      options[:fullscreen] = true
    end

    opts.on('-s', '--shuffle', 'Shuffle the slideshow') do
      options[:shuffle] = true
    end

    opts.on('--timer MINUTES', 'Set a timeout to process') do |minutes|
      options[:time] = minutes
    end
  end
  option_parser.parse!

  puts option_parser

  # > picture --depth 2 DIR
  # > picture --slideshow .
  # > picture --fullscreen IMG
end
