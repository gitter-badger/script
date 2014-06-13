#!/usr/bin/ruby -w
# parse.rb
# Author: Andy Bettisworth
# Description: READ grammar rules of Ruby scripts

require 'optparse'
require 'ripper'
require 'pp'

raise 'WARNING: only 1 script at a time. ' if ARGV.size > 1

filename = ARGV[0]
script = File.open(filename, 'r')
code = String.new
script.each_line do |line|
  code << line
end

tokens = Ripper.sexp(code)
tokens.each do |t|
  puts t.to_s
end
