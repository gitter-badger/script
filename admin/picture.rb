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
    def initialize(timeout = nil, depth = 0, is_fullscreen = false)
      @timeout       = timeout
      @depth         = depth
      @is_fullscreen = is_fullscreen
    end

    def launch
      if @timeout
        `timeout #{@timeout} shotwell`
      else
        `shotwell`
      end
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

    opts.on('-o', '--open', 'Open matching picture(s)') do
      options[:open] = true
    end

    opts.on('-i', '--info FILE', 'Show picture information') do |picture|
      options[:info] = picture
    end

    opts.on('--log', 'Show ~/Pictures log') do
      options[:log] = true
    end
  end
  option_parser.parse!

  puts option_parser
  exit 1
end
