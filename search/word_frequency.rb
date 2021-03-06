#!/usr/bin/env ruby -w
# word_frequency.rb
# Author: Andy Bettisworth
# Description: Return Array of words and their frequencies from a file

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'search/search'

module Search
  # return array of unique words with usage counts
  class WordFrequency
    include Admin
    
    def get(file)
      if File.exist?(file)
        content = File.open(file).read
        content_array = content.downcase.split(/\b/).select { |x| /\w/.match(x) }
        content_hash = {}
        content_array.each { |word| content_hash.key?(word) ? content_hash[word] += 1 : content_hash[word] = 1 }
        content_hash = content_hash.sort_by { |_k, v| v }.reverse.to_h
        puts content_hash.inspect
        content_hash
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Search

  if ARGV[0]
    counter = WordFrequency.new
    counter.get(ARGV[0])
  else
    puts 'Usage: word_frequency FILENAME'
    exit 1
  end
end
