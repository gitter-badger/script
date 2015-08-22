#!/usr/bin/env ruby -w
# crawl.rb
# Author: Andy Bettisworth
# Description: Extracting view layer content from remote servers

require 'nokogiri'
require 'open-uri'
require 'timeout'
require 'uri'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'search/search'

module Search
  class Crawler
    include Admin
    
    def get_webpage(url)
      Timeout::timeout(5) do
        ensure_valid_uri(url)
        document = Nokogiri::HTML(open(url))
        puts document.text
      end
    end

    def get_webpage_filter_css(url, css_pattern)
      Timeout::timeout(5) do
        ensure_valid_uri(url)
        document = Nokogiri::HTML(open(url))
        document = document.css(css_pattern)
        puts document
        return document
      end
    end

    private

    def ensure_valid_uri(url)
      unless url =~ URI::regexp
        STDERR.puts 'InvalidURIError: URI provided was invalid'
        exit 1
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Search
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: crawl [options] URL'

    opts.on('-c ELEMENT', '--css ELEMENT', 'Filter by CSS elements') do |element|
      options[:css] = element
    end
  end
  option_parser.parse!

  handsy = Crawler.new

  if options[:css]
    handsy.get_webpage_filter_css(ARGV[0], options[:css])
  elsif ARGV[0]
    handsy.get_webpage(ARGV[0])
  else
    puts option_parser
  end
end
