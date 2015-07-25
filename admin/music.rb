#!/usr/bin/env ruby
# music.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220942
# Modified At: 2015 0513 220942
# Description: Manage ~/Music

require_relative 'admin'

module Admin
  # manage all local ~/Music
  class Music
    MUSIC_DIR = "#{ENV['HOME']}/Music"

    def list(query = nil)
      music = grab_all_files(MUSIC_DIR)
      music = filter_files(music, query) if query
      print_files(music)
      music
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: music [options] FILE'

    opts.on('-l', '--list [REGEXP]', 'List matching music') do |regexp|
      options[:list] = true
      options[:list_regexp] = regexp
    end

    opts.on('-f', '--fetch', 'Copy matching music to ~/Desktop') do
      options[:fetch] = true
    end

    opts.on('-o', '--open', 'Open matching music') do
      options[:open] = true
    end

    opts.on('-i', '--info FILE', 'Show music information') do |music|
      options[:info] = music
    end

    opts.on('-c', '--category FILTER', 'Filter by category') do |category|
      options[:category] = category
    end

    opts.on('--playlist PLAYLIST', 'Start a playlist') do |playlist|
      options[:playlist] = playlist
    end

    opts.on('--timeout MINUTES', 'Set to timeout after X minutes ') do |minutes|
      options[:timeout] = minutes
    end

    opts.on('--radio [STATION]', 'Start a radio stream') do |station|
      options[:radio] = true
      options[:radio_station] = station
    end

    opts.on('--log', 'Show ~/Music log') do
      options[:log] = true
    end
  end
  option_parser.parse!

  music_mgr = Music.new

  if options[:list]
    music_mgr.list(options[:list_regexp])
  else
    puts option_parser
    exit 1
  end
end
