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
  end
  option_parser.parse!

  puts option_parser

  # ## Play matching videos and put it on shuffle
  # video --shuffle samurai champloo

  # ## Play video and timeout after 20 minutes
  # video --timer 20
end
