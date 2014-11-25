#!/usr/bin/env ruby
# scrape_mobotix_api.rb
# Author: Andy Bettisworth
# Created At: 2014 1125 145522
# Modified At: 2014 1125 145522
# Description: Scrape the Mobotix Camera API from their docs

require 'nokogiri'
require 'open-uri'
require 'optparse'

if __FILE__ == $0
  url = 'http://developer.mobotix.com/paks/help_cgi-remotecontrol.html'
  doc = Nokogiri::HTML(open(url))
  puts doc.text
else
  STDERR.puts 'Error: This is a command-line application not a library.'
  exit 1
end