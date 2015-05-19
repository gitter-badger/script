#!/usr/bin/env ruby
# picture.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220924
# Modified At: 2015 0513 220924
# Description: Manage Pictures

require 'optparse'

module Admin
  class Picture
    def initialize(timeout, depth, is_fullscreen)
      @timeout = timeout
      @depth = depth
      @is_fullscreen = is_fullscreen
    end

    def launch
      `shotwell`
    end
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

    opts.on('-f', '--fullscreen', 'Maximize photo browser window') do
      options[:fullscreen] = true
    end

    opts.on('-s', '--shuffle', 'Shuffle the slideshow') do
      options[:shuffle] = true
    end

    opts.on('--timeout MINUTES', 'Set a timeout to the process') do |minutes|
      options[:timeout] = minutes
    end
  end
  option_parser.parse!


  if ARGV.size > 0
    timout = 0
    depth = 0
    is_fullscreen = false

    if options[:timeout] and options[:timeout].is_a? Integer
      timeout = options[:timeout]
    end
    depth = options[:depth] if options[:depth]
    is_fullscreen = true if options[:fullscreen]

    admin_picture = Admin::Picture.new(timeout, depth, is_fullscreen)

    if options[:slideshow]
      admin_picture.slideshow
    else
      admin_picture.launch
    end
  end

  puts option_parser
  exit 1
end
