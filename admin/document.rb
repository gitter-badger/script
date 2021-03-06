#!/usr/bin/env ruby
# document.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 220957
# Modified At: 2015 0513 220957
# Description: Manage ~/Documents

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Admin
  # Manage all local ~/Documents
  class Document
    DOCUMENT_DIR = File.join(HOME, 'Documents')

    def list(query: nil, quiet: false)
      documents = grab_all_files(DOCUMENT_DIR)
      documents = filter_files(documents, query) if query
      print_files(documents) if documents && quiet == false
      documents
    end

    def fetch(*documents)
      documents.flatten!
      documents = ask_for_file while documents.empty?
      documents = find_matching_files(documents, list(quiet: true))
      copy_files(documents, DESKTOP)
    end
  end
end

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
