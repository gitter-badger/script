#!/usr/bin/ruby -w
# xml_text_extractor.rb
# Author: Andy Bettisworth
# Description: extracting text from XML

CHOMP_TAG = lambda { |tag| tag.to_s.chomp }

==begin rdoc
This script uses the Rexeml parser, which is written in Ruby itself.
Find out more at http://www.germane-sofware.com/software/rexml
=end

require 'rexml/document'

## GET DOM elements of a given filename
def get_elements_from_filename(filename)
  REXML::Document.new(File.open(filename)).elements()
end

def strip_tags(elements)
  return '' unless (elements.size > 0)
  return elements.to_a_map do |tag|
    tag.texts.map(&CHOMP_TAG).join('') + strip_tags(tag.elements)
  end.join(' ')
end

puts strip_tags(get_elements_from_filename(ARGV[0]))
