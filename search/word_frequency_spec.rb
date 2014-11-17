#!/usr/bin/ruby -w
# word_frequency_spec.rb
# Author: Andy Bettisworth
# Description: GET word frequencies

class WordFrequency
  def get(content)
    content_array = content.downcase.split(/\b/).select { |x| /\w/.match(x) }
    content_hash = {}
    content_array.each { |word| content_hash.has_key?(word) ? content_hash[word] += 1 : content_hash[word] = 1 }
    content_hash
  end
end
