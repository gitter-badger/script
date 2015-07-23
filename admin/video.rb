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
    def initialize(timeout = nil)
      @timeout = timeout
    end

    def launch
      if @timeout
        `timeout #{@timeout} totem`
      else
        `totem`
      end
    end

    def shuffle
      launch
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

    opts.on('-o', '--open', 'Open matching video(s)') do
      options[:open] = true
    end

    opts.on('-i', '--info FILE', 'Show video information') do |video|
      options[:info] = video
    end

    opts.on('--log', 'Show ~/Videos log') do
      options[:log] = true
    end
  end
  option_parser.parse!

  puts option_parser
  exit 1
end
