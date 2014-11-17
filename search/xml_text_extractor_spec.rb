#!/usr/bin/ruby -w
# xml_text_extractor.rb
# Author: Andy Bettisworth
# Description: extracting text from XML

CHOMP_TAG = lambda { |tag| tag.to_s.chomp }

require 'rexml/document'

class XMLExtractor
  def get_elements(filename)
    REXML::Document.new(File.open(filename)).elements()
  end

  def strip_tags(elements)
    return '' unless (elements.size > 0)
    return elements.to_a_map do |tag|
      tag.texts.map(&CHOMP_TAG).join('') + strip_tags(tag.elements)
    end.join(' ')
  end
end

if __FILE__ == $0
  tractor = XMLExtractor.new
  puts strip_tags(tractor.get_elements(ARGV[0]))
end
