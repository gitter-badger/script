#!/usr/bin/env ruby
# picture.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220924
# Modified At: 2015 0513 220924
# Description: Manage Pictures

require_relative 'admin'

module Admin
  # manage all local ~/Pictures
  class Picture
    def initialize(timeout = nil, depth = 0, is_fullscreen = false)
      @timeout       = timeout
      @depth         = depth
      @is_fullscreen = is_fullscreen
    end

    def launch
      if @timeout
        `timeout #{@timeout} shotwell`
      else
        `shotwell`
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: picture [options] DIR'

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

  timeout       = options[:timeout] ? options[:timeout] : nil
  depth         = options[:depth] ? options[:depth] : 0
  is_fullscreen = options[:fullscreen] ? options[:fullscreen] : false

  admin_picture = Picture.new(timeout, depth, is_fullscreen)

  if options[:slideshow]
    admin_picture.slideshow
  else
    admin_picture.launch
  end
end
