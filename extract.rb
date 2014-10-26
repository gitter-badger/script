#!/usr/bin/ruby -w
# extract.rb
# Author: Andy Bettisworth
# Description: Extract lines matching REGEXP into a new file

require 'optparse'

class Extract
  def extract_lines(input_file, output_file, regexp)
    raise "FileNotFoundError: Please provide an existing file as input." unless File.exist?(input_file)

    filter = Regexp.new(regexp)

    filtered_content = []
    File.open(input_file).each_line do |line|
      if filter.match(line)
        filtered_content << line
      end
    end

    File.open(output_file, 'w+') do |file|
      filtered_content.each { |line| file.puts(line) }
    end
  end
end

if __FILE__ == $0
  options = {}
  OptionParser.new do |opts|
    opts.banner = 'USAGE: extract -i [INPUT_FILE] -o [OUTPUT_FILE] -r [REGEXP]'

    opts.on('-i [INPUT]', '--input [INPUT]', 'Targeted file to filter') do |input_file|
      options[:input] = input_file.to_s
    end

    opts.on('-o [OUTPUT]', '--output [OUTPUT]', 'New file with filtered content') do |output_file|
      options[:output] = output_file.to_s
    end

    opts.on('-r [REGEXP]', '--regexp [REGEXP]', 'Regular expression used as a filter') do |regexp|
      options[:regexp] = regexp.to_s
    end
  end.parse!

  extractor = Extract.new
  if options[:input]
    if options[:output]
      if options[:regexp]
        extractor.extract_lines(options[:input], options[:output], options[:regexp])
      else
        puts 'requires a regular expression'
      end
    else
      puts 'requires an output file'
    end
  else
    puts 'requires an input file'
  end
end
