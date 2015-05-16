#!/usr/bin/env ruby
# music.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220942
# Modified At: 2015 0513 220942
# Description: Manage Music

require 'optparse'

module Admin
  class Music
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: music [options] REGEXP"
  end
  option_parser.parse!

  puts option_parser

  # ## Filter by category
  # music --filter Guardian

  # ## List available playlists
  # music --playlist

  # ## Play music in target playlist
  # music --playlist Chillosophy

  # ## Open radio stream and record it
  # radio --record 88.7

  # ## List all podcasts
  # podcast --list
end
