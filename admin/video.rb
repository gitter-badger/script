#!/usr/bin/env ruby
# video.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220907
# Modified At: 2015 0513 220907
# Description: Manage Videos

require 'optparse'

module Admin
  class Video
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: video [options] REGEXP"

    opts.on('-s', '--shuffle', 'Shuffle the playlist') do
      options[:shuffle] = true
    end

    opts.on('--timer MINUTES', 'Set a timeout to process') do |minutes|
      options[:time] = minutes
    end
  end
  option_parser.parse!

  puts option_parser

  # > video --shuffle samurai champloo
  # > video --timer 20
end
