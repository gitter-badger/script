#!/usr/bin/ruby -w
# tokenize.rb
# Author: Andy Bettisworth
# Description: READ tokenization of Ruby scripts

require 'optparse'
require 'ripper'
require 'pp'

class RubyTokenization
  def tokenize(filename, output=nil)
    code = get_code(filename)
    tokens = Ripper.lex(code)
    tokens.each do |token|
      puts token.to_s
    end
  end

  def get_code(filename)
    File.open(filename).read
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = "USAGE: tokenize [options] SCRIPT"

  opts.on('-o FILE', '--output FILE', 'File for tokenization output') do |file|
    options[:output] = file
  end
end
option_parser.parse!

## USAGE
raise 'WARNING: only tokenize 1 script at a time.' if ARGV.size > 1
tokenizer = RubyTokenization.new
if options[:output] && ARGV[0]
  tokenizer.tokenize(ARGV[0], options[:output])
elsif ARGV[0]
  tokenizer.tokenize(ARGV[0])
else
  puts option_parser
end
