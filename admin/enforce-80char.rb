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
        f.flock(File::LOCK_SH)
        f.each_line do |line|
          if line.size > 80
            tmp.puts get_line(line)
          else
            tmp.puts line
          end
        end
        f.flock(File::LOCK_UN)
      end

      tmp.close
      # FileUtils.mv(tmp.path, file)
    else
      puts "File does not exist at '#{file}'"
    end
  end

  def get_line(line)
    if line.size > 80
      line_count = line.size / 80
      remainder  = line.size % 80
      full_line = ''
      token_char = 0
      line_count.times do |i|
        start_char   = i * 80
        start_char  += 1 if start_char != 0
        end_char     = (i+1) * 80
        # > check if first line had a preceding hashtag
        #   > if yes, include #
        #   > if no, do not include #
        puts "line: #{line[start_char..end_char]}"
        full_line   += "# #{line[start_char..end_char]}\n"
        token_char   = end_char
      end
      full_line += "# #{line[(token_char + 1)..(token_char + (remainder - 1))]}"
      return full_line
    else
      return line
    end
  end
end

if __FILE__ == $0
  require 'optparse'

  option_parser = OptionParser.new do |opts|
    opts.banner = "USAGE: enforce-80char FILE"
  end
  option_parser.parse!

  enforcer = Enforce80Char.new

  if ARGV.count == 1
    enforcer.convert(ARGV[0])
  else
    puts option_parser
  end
end
