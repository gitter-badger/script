#!/usr/bin/env ruby -w
# rename_spec.rb
# Description: rename files

require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|
  executable_name = File.basename($PROGRAM_NAME).gsub('.rb','')
  opts.banner = "Usage: #{executable_name} [options] file|dir"

  opts.on('-r','--recursive','rename files recursively') do
    options[:recursive] = true
  end
end

# GET options
option_parser.parse!
if ARGV.empty?
  puts "error: you must supply a target file or directory"
  puts
  puts option_parser.help
end

class RenameFile
  attr_accessor :options
  attr_accessor :target_dir
  attr_accessor :match_pattern
  attr_accessor :update_pattern

  def initialize(options)
    @options = options
  end

  ## USAGE
  # rename /^(?<x>canvas)_(?<y>w.*)/ <y>_<x>
  # rename -R /^(?<x>canvas)_(?<y>w.*)/ <y>_<x>
  def rename(match_pattern, update_pattern)
    @target_dir = Dir.getwd
    @match_pattern = match_pattern
    @update_pattern = update_pattern

    if File.directory?(@target_dir)
      loop_directory(@target_dir)
    else
      rename_file(@target_dir)
    end
  end

  private
  def rename_file(file, dir = @target_dir)
    if @match_pattern =~ file
      new_filename = @update_pattern

      @match_pattern.named_captures.each_key do |key|
        match_pos = @match_pattern.named_captures[key][0]
        replace_value = @match_pattern.match(file)[match_pos]
        new_filename.gsub!("<#{key}>", replace_value)
      end

      puts 'name: ' + new_filename
      # > update new filename during recursive loop
      File.rename("#{dir.to_s}/#{file.to_s}", new_filename)
    end
  end

  def loop_directory(dir)
    Dir.foreach(dir) do |item|
      next if item == '.' or item == '..' or File.directory?(item)
      rename_file(item)
    end
    if @options[:recursive] == true
      Dir["**/"].each do |recursive_dir|
        Dir.foreach(recursive_dir) do |item|
          next if item == '.' or item == '..' or File.directory?(item)
          rename_file(item, "#{dir}/#{recursive_dir.gsub(/\/$/,'')}")
        end
      end
    end
  end
end

## EXEC rename
# namer = RenameFile.new(options)
# unless ARGV.size == 1
#   ARGV.size.times do |i|
#     namer.rename(ARGV[i])
#   end
# end
# namer.rename(ARGV[0])

describe RenameFile do
  HOME = ENV['HOME'] + "/Desktop"

  def create_test_file
    File.new(HOME + '/test_file','w+')
  end

  def create_test_dir
    unless Dir.exists?(HOME + '/test_dir1')
      Dir.mkdir(HOME + '/test_dir1')
    end
    unless Dir.exists?(HOME + '/test_dir1/test_dir2')
      Dir.mkdir(HOME + '/test_dir1/test_dir2')
    end
    File.new(HOME + '/test_dir1/test_file1','w+')
    File.new(HOME + '/test_dir1/test_dir2/test_file2_a','w+')
    File.new(HOME + '/test_dir1/test_dir2/test_file2_b','w+')
  end

  before(:each) do
    @options ||= {}
    @namer = RenameFile.new(@options)
  end

  after(:each) do
    Dir.chdir(HOME)
    @options = {}
  end

  describe "#rename" do
    it "should rename all files in current dir", wip: true do
      create_test_file
      @namer.rename(Regexp.new("(?<x>test)_(?<y>file)"), '<y>_<x>')
      expect(File.exist?(HOME + "/file_test")).to be_true
    end

    it "should rename files recursively from current dir" do
      create_test_dir
      Dir.chdir(HOME + '/test_dir1')
      @options[:recursive] = true
      @namer.rename(Regexp.new('(?<x>test)_(?<y>\w.*)'), '<y>_<x>')
      expect(File.exist?(HOME + "/test_dir1/test_dir2/file2_b_test")).to be_true
    end
  end
end
