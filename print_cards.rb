#!/usr/bin/ruby -w
# print_cards.rb
# Author: Andy Bettisworth
# Description: Print all PDF found

require 'logger'

path = ARGV[0] || '/tmp'
interval = ARGV[1] || 10
interval = interval.to_i

logfile = File.dirname(__FILE__) + '/watcher.log'
logger = Logger.new(logfile)
logger.info('Started the watcher..')

loop do
  files = Dir["#{path}/*.pdf"]
  files.each do |filename|
    logger.info("Processing #{filename}.")
    %x(print_card #{filename})
    File.delete(filename)
  end
  sleep(interval)
end
