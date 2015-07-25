#!/usr/bin/env ruby
# picture.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220924
# Modified At: 2015 0513 220924
# Description: Manage ~/Pictures

require_relative 'admin'

module Admin
  # manage all local ~/Pictures
  class Picture
    PICTURE_DIR = "#{ENV['HOME']}/Pictures"

    def list(query = nil)
      pictures = grab_all_files(PICTURE_DIR)
      pictures = filter_files(pictures, query) if query
      print_files(pictures)
      pictures
    end

    def fetch(*pictures)
      pictures.flatten!
      pictures = ask_for_file while pictures.empty?
      pictures = append_default_ext(pictures)
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

    # opts.on('-o', '--open', 'Open matching picture(s)') do
    #   options[:open] = true
    # end
    #
    # opts.on('-i', '--info FILE', 'Show picture information') do |picture|
    #   options[:info] = picture
    # end
    #
    # opts.on('--log', 'Show ~/Pictures log') do
    #   options[:log] = true
    # end
  end
  option_parser.parse!

  picture_mgr = Picture.new

  if options[:list]
    picture_mgr.list(options[:list_regexp])
  elsif options[:fetch]
    picture_mgr.fetch(ARGV)
  else
    puts option_parser
    exit 1
  end
end
