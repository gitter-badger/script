#!/usr/bin/env ruby
# download.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 221014
# Modified At: 2015 0513 221014
# Description: Manage ~/Downloads

require_relative 'admin'

module Admin
  # manage all local ~/Downloads
  class Download
    DOWNLOAD_DIR = File.join(HOME, 'Downloads')

    def list(query: nil, quiet: false)
      downloads = grab_all_files(DOWNLOAD_DIR)
      downloads = filter_files(downloads, query) if query
      print_files(downloads) if downloads && quiet == false
      downloads
    end

    def fetch(*downloads)
      downloads.flatten!
      downloads = ask_for_file while downloads.empty?
      downloads = find_matching_files(downloads, list(quiet: true))
      copy_files(downloads, DESKTOP)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: download [options] FILE'

    opts.on('-l', '--list [REGEXP]', 'List matching download(s)') do |regexp|
      options[:list] = true
      options[:list_regexp] = regexp
    end

    opts.on('-f', '--fetch', 'Copy matching download(s) to ~/Desktop') do
      options[:fetch] = true
    end
  end
  option_parser.parse!

  download_mgr = Download.new

  if options[:list]
    download_mgr.list(query: options[:list_regexp])
  elsif options[:fetch]
    download_mgr.fetch(ARGV)
  else
    puts option_parser
    exit 1
  end
end
