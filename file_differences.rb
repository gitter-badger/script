#!/usr/bin/ruby -w
# file_differences.rb
# Author: Andy Bettisworth
# Description: Print the difference between files

first_file = ARGV[0]
second_file = ARGV[1]

raise "Two files are required for this command." unless ARGV[0] and ARGV[1]

raise "Not a file at '#{first_file}'." unless File.exist?(first_file)
raise "Not a file at '#{second_file}'." unless File.exist?(second_file)

first_file_content = File.open(first_file).readlines
second_file_content = File.open(second_file).readlines

puts "The following file content is new: "
puts first_file_content - second_file_content
