#!/usr/bin/env ruby
# tesseract.rb
# Author: Andy Bettisworth
# Created At: 2015 0119 152915
# Modified At: 2015 0119 152915
# Description: Tesseract OCR or Optical Character Recognition

require 'rtesseract'
require 'optparse'

require_relative 'search'

module Search
  class Tesseract
  end
end

if __FILE__ == $PROGRAM_NAME
  include Search

  tess = Tesseract.new
  tess.parse(ARGV[0])
end
