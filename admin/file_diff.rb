#!/usr/bin/ruby -w
# file_diff.rb
# Author: Andy Bettisworth
# Description: Print the difference between files

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Admin
  # Get the difference between two files
  class FileDiff
    def run(file1, file2)
      raise "Not a file at '#{file1}'." unless File.exist?(file1)
      raise "Not a file at '#{file2}'." unless File.exist?(file2)

      file1_content = File.open(file1).readlines
      file2_content = File.open(file2).readlines

      puts 'The following file content is new: '
      puts file1_content - file2_content
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  file1  = ARGV[0]
  file2 = ARGV[1]
  comparison = FileDiff.new
  comparison.run(file1, file2)
end
