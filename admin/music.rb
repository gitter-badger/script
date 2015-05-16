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

    opts.on('--filter FILTER', 'Filter by category') do |filter|
      options[:filter] = filter
    end

    opts.on('--playlist PLAYLIST', 'Start a playlist') do |playlist|
      options[:playlist] = playlist
    end

    opts.on('-s', '--shuffle', 'Shuffle the playlist') do
      options[:shuffle] = true
    end

    opts.on('--timeout MINUTES', 'Set a timeout to process') do |minutes|
      options[:timeout] = minutes
    end

    opts.on('--podcast PODCAST', 'Filter by podcast') do |podcast|
      options[:podcast] = podcast
    end

    opts.on('--radio', 'Start a radio stream') do
      options[:radio] = true
    end

    opts.on('-r', '--record FILE', 'Record music to file') do |file|
      options[:record] = file
    end
  end
  option_parser.parse!

  puts option_parser

  # > music --filter Guardian
  # > music --playlist
  # > music --shuffle --playlist Chillosophy
  # > music --record --radio 88.7
  # > music --podcast Snap Judgment
end
