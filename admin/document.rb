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

    opts.on('--filter FILTER', 'Filter by category') do |filter|
      options[:filter] = filter
    end

    opts.on('--fetch REGEXP', 'Fetch document(s) by regular expression') do |regexp|
      options[:fetch] = regexp
    end
  end
  option_parser.parse!

  if ARGV.size > 0
    puts 'Success'
    # > document --filter Technical Elegant Ruby
    # > document --fetch On Writing Well
    # > document Rise of the Ogre
  end
  puts option_parser
  exit 1

end
