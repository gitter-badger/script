#!/usr/bin/env ruby
# music.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220942
# Modified At: 2015 0513 220942
# Description: Manage Music

require 'optparse'

module Admin
  class Music
    def initialize(is_shuffle, is_record, timeout)
      @is_shuffle = is_shuffle
      @is_record  = is_record
      @timeout    = timeout
    end

    def launch
      `rhythmbox`
    end
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

    opts.on('--timeout MINUTES', 'Set a timeout to the process') do |minutes|
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

  if options[:timeout] and options[:timeout].is_a? Integer
    timeout = options[:timeout]
  end
  is_shuffle = true if options[:shuffle]
  is_record  = true if options[:record]

  admin_music = Admin::Music.new(is_shuffle, is_record, timeout)

  if options[:filter]
    admin_music.filter(ARGV)
  elsif options[:playlist]
    admin_music.playlist(ARGV)
  elsif options[:radio]
    admin_music.radio(ARGV)
  elsif options[:podcast]
    admin_music.podcast(ARGV)
  else
    admin_music.launch
  end
end
