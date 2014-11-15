#!/usr/bin/ruby -w
# parse.rb
# Author: Andy Bettisworth
# Description: READ grammar rules of Ruby scripts

require 'optparse'
require 'ripper'
require 'pp'

class ScriptRipper
  def run
    raise 'WARNING: only 1 script at a time. ' if ARGV.size > 1

    filename = ARGV[0]
    script = File.open(filename, 'r')
    code = String.new
    script.each_line do |line|
      code << line
    end

    parsed_code = Ripper.sexp(code)
    parsed_code.each do |t|
      puts t.to_s
    end
  end
end

if __FILE__ == $0
  mgmt = ScriptRipper.new
  mgmt.run
end
