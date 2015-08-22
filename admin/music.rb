#!/usr/bin/env ruby
# music.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220942
# Modified At: 2015 0513 220942
# Description: Manage ~/Music

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Admin
  # manage all local ~/Music
  class Music
    MUSIC_DIR = File.join(HOME, 'Music')

    def list(query: nil, quiet: false)
      music = grab_all_files(MUSIC_DIR)
      music = filter_files(music, query) if query
      print_files(music) if music && quiet == false
      music
    end

    def fetch(*music)
      music.flatten!
      music = ask_for_file while music.empty?
      music = find_matching_files(music, list(quiet: true))
      copy_files(music, DESKTOP)
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
