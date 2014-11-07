#!/usr/bin/env ruby -w
# enforce-80char.rb
# Author: Andy Bettisworth
# Created At: 2014 1106 120459
# Modified At: 2014 1106 120459
# Description: automatically will add newlines to lines extending beyond 80 characters

require 'fileutils'
require 'tempfile'

class Enforce80Char
  def convert(file)
    if File.exist?(file)
      tmp = Tempfile.new(file)
      File.open(file, 'r') do |f|
        f.each_line do |line|
          if line.size > 80
            tmp.puts line[0..80]
            tmp.puts "# #{line[80..-1]}"
          else
            tmp.puts line
          end
        end
      end
      tmp.close
      FileUtils.mv(tmp.path, file)
    else
      puts "File does not exist at '#{file}'"
    end
  end
end

if __FILE__ == $0
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "USAGE: enforce-80char [options] FILE"
  end
  option_parser.parse!

  enforcer = Enforce80Char.new

  if ARGV.count == 1
    enforcer.convert(ARGV[0])
  else
    puts option_parser
  end
end
