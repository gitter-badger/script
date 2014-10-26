#!/usr/bin/ruby -w
# rename_file.rb
# Author: Andy Bettisworth
# Description: Rename all files in current directory using Regexp

require 'optparse'

class FileRenamer
  def replace(regexp_match, substitute)
    Dir.foreach('.') do |file|
      next if File.directory?(file)
      File.rename(file, file.gsub(regexp_match, substitute))
    end
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "USAGE: rename_file [options]"

    opts.on('-m REGEXP', '--match REGEXP', 'Regular expression used to match files') do |regexp|
      options[:match] = regexp
    end

    opts.on('-r FILENAME', '--replace FILENAME', 'String to replace regexp match') do |filename|
      options[:replace] = filename
    end
  end
  option_parser.parse!

  renamer = FileRenamer.new
  if options[:match] && options[:replace]
    renamer.replace(options[:match], options[:replace])
  else
    puts option_parser
  end
end
