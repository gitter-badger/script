#!/usr/bin/env ruby
# songs.rb
# Author: Andy Bettisworth
# Created At: 2015 0725 121541
# Modified At: 2015 0725 121541
# Description: symbolic link to music.rb script

require_relative 'music'

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
  end
  option_parser.parse!

  music_mgr = Music.new

  if options[:list]
    music_mgr.list(query: options[:list_regexp])
  elsif options[:fetch]
    music_mgr.fetch(ARGV)
  else
    puts option_parser
    exit 1
  end
end
