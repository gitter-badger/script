#!/usr/bin/env ruby
# music.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220942
# Modified At: 2015 0513 220942
# Description: Manage Music

require 'optparse'

module Admin
  class Music
    def initialize(timeout=nil, is_shuffled=false, is_recorded=false)
      @timeout     = timeout
      @is_shuffled = is_shuffled
      @is_recorded = is_recorded
    end

    def launch
      if @timeout
        `timeout #{@timeout} rhythmbox`
      else
        `rhythmbox`
      end
    end
  end
end

if __FILE__ == $0
  include Admin

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: music [options] REGEXP"

    opts.on('-c', '--category FILTER', 'Filter by category') do |category|
      options[:category] = category
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

  timeout     = options[:timeout] ? options[:timeout] : nil
  is_shuffled = options[:shuffle] ? options[:shuffle] : false
  is_recorded = options[:record] ? options[:record] : false

  admin_music = Music.new(timeout, is_shuffled, is_recorded)

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
