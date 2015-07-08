#!/usr/bin/env ruby -w
# enforce-80char.rb
# Author: Andy Bettisworth
# Created At: 2014 1106 120459
# Modified At: 2014 1106 120459
# Description: enforce 80 character limit per line

require 'fileutils'
require 'tempfile'

require_relative 'admin'

module Admin
  class StyleGuide
    def enforce_80char(file_path)
      require_file(file_path)

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
      FileUtils.mv(tmp.path, file)
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
          if /^#/.match(line[start_char..end_char])
            full_line   += "#{line[start_char..end_char]}\n"
          else
            full_line   += "# #{line[start_char..end_char]}\n"
          end
          token_char   = end_char
        end
        full_line += "# #{line[(token_char + 1)..(token_char + (remainder - 1))]}"
        return full_line
      else
        return line
      end
    end
  end
end

if __FILE__ == $0
  include Admin

  is_valid = true
  is_valid = false unless ARGV[0]

  if is_valid
    enforcer = StyleGuide.new
    enforcer.enforce_80char(ARGV[0])
  else
    puts 'Usage: enforce-80char FILE'
  end
end
