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
  LOCALE = ['BR','CA','CN','DE','ES','FR','GB','IN','IT','JP','US']

  attr_accessor :request

  def initialize(locale=nil)
    if LOCALE.include?(locale)
      @request = Vacuum.new(locale)
    else
      @request = Vacuum.new
    end

    @request.configure(
        aws_access_key_id:     'AKIAJ642JMWDFLXV6JVA',
        aws_secret_access_key: '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',
        associate_tag:         'wurde'
    )
  end

  def send(index, keyword=nil)
    exit_if_no_connection

    params = {
      'SearchIndex'   => index,
      'Keywords'      => keyword
    }

    puts "Searching for '#{keyword}' in '#{index}' on Amazon.com..."
    result = @request.item_search(query: params)
    puts result.to_h
  end

  private

  def exit_if_no_connection
    # > check conn or exit 3
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "USAGE: amazon-query SEARCH_INDEX [options]"

    opts.on('-k KEYWORD', '--keyword KEYWORD', 'Search by word or phrase') do |key|
      options[:keyword] = key
    end
  end
  option_parser.parse!

  req = AmazonQuery.new

  if ARGV.count > 0
    if options[:keyword]
      req.send(ARGV.join(' '), options[:keyword])
    else
      req.send(ARGV.join(' '))
    end
  else
    STDERR.puts option_parser
    exit 2
  end
end
