#!/usr/bin/env ruby -w
# amazon-query.rb
# Author: Andy Bettisworth
# Created At: 2014 1107 174313
# Modified At: 2014 1107 174313
# Description: Query Amazon Product API
# http://docs.aws.amazon.com/AWSECommerceService/latest/DG/Welcome.html

require 'optparse'
require 'vacuum'

class AmazonQuery
  def send(item, market='amazon.com')
    request = Vacuum.new
    request.associate_tag = 'wurde'

    puts "Searching for '#{item}' on Amazon.com..."
    result = request.item_search(query: item)
    puts result.to_h
  end
end

if __FILE__ == $0
  options = []
  option_parser = OptionParser.new do |opts|
    opts.banner = "USAGE: amazon-query SEARCH_INDEX [options]"

    opts.on('-k KEYWORD', '--keyword KEYWORD', 'Search by word or phrase') do |key|
      options[:keyword] = key
    end
  end
  option_parser.parse!

  req = AmazonQuery.new

  if ARGV.count > 0
    req.send(ARGV.join(' '))
  else
    STDERR.puts option_parser
    exit 2
  end
end
