#!/usr/bin/env ruby
# download.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 221014
# Modified At: 2015 0513 221014
# Description: Manage Downloads

require 'optparse'

module Admin
  class Download
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: document [options] REGEXP"
  end
  option_parser.parse!

  puts option_parser

  # ## Delete all files in download directory, password to confirm
  # download --flush

  # ## Move most recent file to Desktop
  # download --pop

  # ## List downloads sort by most recent
  # download --list

  # ## Fetch downloads that match regular expression
  # download --fetch REGEXP
end
