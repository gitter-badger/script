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
    def initialize(timeout = nil, is_shuffled = false, is_recorded = false)
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

  puts option_parser
  exit 1
end
