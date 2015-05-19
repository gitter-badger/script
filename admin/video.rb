#!/usr/bin/env ruby
# video.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220907
# Modified At: 2015 0513 220907
# Description: Manage Videos

require 'optparse'

module Admin
  class Video
    def initialize(timeout)
      @timeout = timeout
    end

    def launch
      `totem`
    end
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: video [options] REGEXP"

    opts.on('-s', '--shuffle', 'Shuffle the playlist') do
      options[:shuffle] = true
    end

    opts.on('-f', '--fullscreen', 'Maximize video player window') do
      options[:fullscreen] = true
    end

    opts.on('--timeout MINUTES', 'Set a timeout to the process') do |minutes|
      options[:timeout] = minutes
    end
  end
  option_parser.parse!

  if options[:timeout] and options[:timeout].is_a? Integer
    timeout = options[:timeout]
  end

  admin_video = Admin::Video.new(timeout)

  if options[:shuffle]
    admin_video.shuffle
  else
    admin_video.launch
  end
end
