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

## USAGE
renamer = FileRenamer.new
if options[:match] && options[:replace]
  renamer.replace(options[:match], options[:replace])
else
  puts option_parser
end

# describe FileRenamer do
#   HOME = ENV['HOME']
#   DESKTOP = "#{HOME}/Desktop"

#   let(:test_dir) { "#{DESKTOP}/rename_files" }

#   before(:each) do
#     Dir.mkdir( test_dir, 0755)
#     File.new("#{test_dir}/001_hidden.rb", 'w')
#     File.new("#{test_dir}/002_hidden.rb", 'w')
#     File.new("#{test_dir}/003_hidden.rb", 'w')
#   end

#   after(:each) do
#     system "rm -rf #{test_dir}"
#   end

#   describe "#rename" do
#     it "should replace /_hidden.rb/ with /_found.rb/" do
#       renamer = FileRenamer.new
#       renamer.replace(/_hidden/, '_found')
#       expect(File.exist?("#{test_dir}/001_found.rb")).to be_true
#       expect(File.exist?("#{test_dir}/002_found.rb")).to be_true
#       expect(File.exist?("#{test_dir}/003_found.rb")).to be_true
#     end
#   end
# end
