#!/usr/bin/env ruby
# video.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220907
# Modified At: 2015 0513 220907
# Description: Manage ~/Videos

require_relative 'admin'

module Admin
  # manage all local ~/Videos
  class Video
    VIDEO_DIR = "#{ENV['HOME']}/Videos"

    def list(query: nil, quiet: false)
      videos = grab_all_files(VIDEO_DIR)
      videos = filter_files(videos, query) if query
      print_files(videos) if videos && quiet == false
      videos
    end

    def fetch(*videos)
      videos.flatten!
      videos = ask_for_file while videos.empty?
      videos = find_matching_files(videos, list(quiet: true))
      copy_files(videos, DESKTOP)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: video [options] FILE'

    opts.on('-l', '--list [REGEXP]', 'List matching video(s)') do |regexp|
      options[:list] = true
      options[:list_regexp] = regexp
    end

    opts.on('-f', '--fetch', 'Copy matching video(s) to ~/Desktop') do
      options[:fetch] = true
    end
  end
  option_parser.parse!

  video_mgr = Video.new

  if options[:list]
    video_mgr.list(query: options[:list_regexp])
  elsif options[:fetch]
    video_mgr.fetch(ARGV)
  else
    puts option_parser
    exit 1
  end
end
