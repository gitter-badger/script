#!/usr/bin/env ruby -w
# pricecheck.rb
# Author: Andy Bettisworth
# Created At: 2014 1107 174313
# Modified At: 2014 1107 174313
# Description: get prices from real world marketplaces

require 'optparse'
require 'vacuum'

class PriceChecker
  def check(item, market='amazon.com')
    request = Vacuum.new
    puts "Searching for '#{item}'..."
    result = request.item_search(query: item)
    puts result
  end
end

if __FILE__ == $0
  option_parser = OptionParser.new do |opts|
    opts.banner = "USAGE: pricecheck ITEM"
  end
  option_parser.parse!

  mkt = PriceChecker.new

  if ARGV.count > 0
    mkt.check(ARGV.join(' '))
  else
    puts option_parser
    exit 2
  end
end
