#!/usr/bin/env ruby
# picture.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220924
# Modified At: 2015 0513 220924
# Description: Manage Pictures

require 'optparse'

module Admin
  class Picture
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: picture [options] REGEXP"
  end
  option_parser.parse!

  puts option_parser

  # ## Open target directory optional depth argument
  # picture --depth 2 DIR

  # ## Play slideshow
  # picture --slideshow .

  # ## Fullscreen
  # picture --fullscreen IMG
end
