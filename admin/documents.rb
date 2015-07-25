#!/usr/bin/env ruby
# documents.rb
# Author: Andy Bettisworth
# Created At: 2015 0725 120910
# Modified At: 2015 0725 120910
# Description: symbolic link to document.rb script

require_relative 'document'

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: document [options] FILE'

    opts.on('-l', '--list [REGEXP]', 'List matching document(s)') do |regexp|
      options[:list] = true
      options[:list_regexp] = regexp
    end

    opts.on('-f', '--fetch', 'Copy matching document(s) to ~/Desktop') do
      options[:fetch] = true
    end

    opts.on('-o', '--open', 'Open matching document(s)') do
      options[:open] = true
    end

    opts.on('-i', '--info FILE', 'Show document information') do |document|
      options[:info] = document
    end

    opts.on('-c', '--category FILTER', 'Filter by category') do |category|
      options[:category] = category
    end

    opts.on('--log', 'Show ~/Documents log') do
      options[:log] = true
    end
  end
  option_parser.parse!

  document_mgr = Document.new

  if options[:list]
    document_mgr.list(query: options[:list_regexp])
  elsif options[:fetch]
    document_mgr.fetch(ARGV)
  else
    puts option_parser
    exit 1
  end
end
