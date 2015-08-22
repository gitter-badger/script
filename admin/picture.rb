#!/usr/bin/env ruby
# picture.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220924
# Modified At: 2015 0513 220924
# Description: Manage ~/Pictures

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Admin
  # manage all local ~/Pictures
  class Picture
    PICTURE_DIR = File.join(HOME, 'Pictures')

    def list(query: nil, quiet: false)
      pictures = grab_all_files(PICTURE_DIR)
      pictures = filter_files(pictures, query) if query
      print_files(pictures) if pictures && quiet == false
      pictures
    end

    def fetch(*pictures)
      pictures.flatten!
      pictures = ask_for_file while pictures.empty?
      pictures = find_matching_files(pictures, list(quiet: true))
      copy_files(pictures, DESKTOP)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: picture [options] FILE'

    opts.on('-l', '--list [REGEXP]', 'List matching picture(s)') do |regexp|
      options[:list] = true
      options[:list_regexp] = regexp
    end

    opts.on('-f', '--fetch', 'Copy matching picture(s) to ~/Desktop') do
      options[:fetch] = true
    end
  end
  option_parser.parse!

  picture_mgr = Picture.new

  if options[:list]
    picture_mgr.list(query: options[:list_regexp])
  elsif options[:fetch]
    picture_mgr.fetch(ARGV)
  else
    puts option_parser
    exit 1
  end
end
