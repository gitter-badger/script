#!/usr/bin/env ruby
# document.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220957
# Modified At: 2015 0513 220957
# Description: Manage Documents

require_relative 'admin'

module Admin
  # Manage all system ~/Documents
  class Document
    DOC_DIR = "#{ENV['HOME']}/Documents"

    attr_accessor :documents
    attr_accessor :query
    attr_accessor :category
    attr_accessor :is_fetch

    def exec
      @documents = query_documents
      filter_documents if @query
      fetch_documents if @is_fetch
      print_list
    end

    def query_documents
      document_list = []

      Dir["#{DOC_DIR}/**/*"].each do |file|
        next if file == '.' || file == '..' || File.directory?(file)
        document_list << file
      end

      document_list
    end

    def filter_documents
      pattern = Regexp.new(@query, Regexp::IGNORECASE)
      @documents = @documents.select! { |e| pattern.match(e) }
      @documents
    end

    def fetch_documents
      puts 'Fetching...'
    end

    def print_list
      @documents.each do |file|
        puts file
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: document [options] REGEXP'

    opts.on('-c', '--category FILTER', 'Filter by category') do |category|
      options[:category] = category
    end

    opts.on('-f', '--fetch', 'Fetch document(s) to Desktop') do
      options[:fetch] = true
    end
  end
  option_parser.parse!

  admin          = Document.new
  admin.category = options[:category] if options[:category]
  admin.is_fetch = true if options[:fetch]
  admin.query    = ARGV[0] if ARGV.size > 0
  admin.query    = ARGV.join(' ') if ARGV.size > 0
  admin.exec
end
