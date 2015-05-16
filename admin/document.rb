#!/usr/bin/env ruby
# document.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220957
# Modified At: 2015 0513 220957
# Description: Manage Documents

require 'optparse'

module Admin
  class Document
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: document [options] REGEXP"
  end
  option_parser.parse!

  puts option_parser

  # ## Filter by category
  # document --filter Technical Elegant Ruby

  # ## Fetch a document
  # document --fetch On Writing Well
end
