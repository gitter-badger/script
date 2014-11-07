#!/usr/bin/env ruby -w
# pricecheck.rb
# Author: Andy Bettisworth
# Created At: 2014 1107 174313
# Modified At: 2014 1107 174313
# Description: get prices from real world marketplaces

require 'optparse'

class PriceChecker
  def check(item, market='amazon.com')
  end
end

if __FILE__ == $0
  option_parser = OptionParser.new do |opts|
    opts.banner = "USAGE: pricecheck [options] ITEM"
  end
  option_parser.parse!

  mkt = PriceChecker.new

  if ARGV.count > 0
    mkt.check(ARGV.join(' '))
  else
    puts option_parser
  end
end
