#!/usr/bin/env ruby -w
# add_shebang.rb
# Description: add ruby shebang line to ruby files

require 'optparse'
require 'fileutils'

options = {}
option_parser = OptionParser.new do |opts|
  executable_name = File.basename($PROGRAM_NAME).gsub('.rb','')
  opts.banner = "Usage: #{executable_name} [options] target_file"

  opts.on('-r','--recursive','add shebang to files recursively') do
    options[:recursive] = true
  end

  opts.on('-f','--force','ignore warnings and force add shebang') do
    options[:force] = true
  end
end

class AddShebang
  RUBY_SHEBANG = "#!/usr/bin/env ruby -w\n"

  attr_accessor :options

  def initialize(options)
    @options = options
  end

  def prepend(target)
    if target.class == Array
      target.each do |file|
        prepend_file(file) unless skip?(file)
      end
    else
      if File.directory?(target)
        loop_directory(target)
      else
        prepend_file(target) unless skip?(target)
      end
    end
  end

  private
  def skip?(file)
    raise "error: missing file #{file}." unless File.exist?(file)
    return true if File.extname(file) != '.rb'
    unless File.open(file).readlines[0].nil?
      return true if File.open(file).grep(/\#\!/).size > 0
    end
    false
  end

  def prepend_file(file)
    new_content = RUBY_SHEBANG
    old_content = IO.read(file)
    File.open(file,'w') {|f| f << new_content << old_content}
  end

  def loop_directory(dir)
    if @options[:recursive] == true
      recursive_loop(dir)
    else
      Dir.foreach(dir) do |item|
        unless skip?(item)
          next if item == '.' or item == '..'
          prepend_file(item)
        end
      end
    end
  end

  def recursive_loop(target)
    target_dir = []
    Dir.foreach(target) do |item|
      next if item == '.' or item == '..'
      target_dir << item if File.directory?(item)
    end
    target_dir << target
    target_dir.each { |dir| loop_directory(dir) }
  end
end

option_parser.parse!
if ARGV.empty?
  puts "error: you must supply a target file or directory"
  puts
  puts option_parser.help
end
# @shebang = AddShebang.new(options)
# unless ARGV.size == 1
#   ARGV.size.times do |i|
#     @shebang.prepend(ARGV[i])
#   end
# end
# @shebang.prepend(ARGV[0])

## EXAMPLE usage
# add_shebang target_file
# add_shebang target_dir
# add_shebang -r .
# add_shebang -rf ../target_dir

describe AddShebang do
  let(:shebang) { "#!/usr/bin/env ruby -w" }
  let(:test_file) { ENV['HOME'] + '/Desktop/test_file.rb' }
  let(:test_dir) { ENV['HOME'] + '/Desktop/test_dir/' }
  let(:error_file) { ENV['HOME'] + '/Desktop/test_file.txt' }

  def pass_options
    options ||= {}
    @shebang = AddShebang.new(options)
  end

  after(:each) do
    options = {}
  end

  describe "#add" do
    it "should accept target file as an argument" do
      pass_options
      File.new(test_file,'w+')
      ARGV[0] = test_file
      @shebang.prepend(ARGV[0])
    end

    it "should prefix target file with the ruby shebang" do
      pass_options
      File.new(test_file,'w+')
      ARGV[0] = test_file
      @shebang.prepend(ARGV[0])
      File.open(test_file).grep(/\#\!/).size.should > 0
    end

    it "should prepend file within target dir" do
      pass_options
      File.new(test_file,'w+')
      ARGV[0] = test_file
      @shebang.prepend(ARGV[0])
      File.open(test_file).readlines[0] =~ /#!\/usr\/bin\/env ruby -w/
    end

    it "should NOT run if file is NOT a ruby file" do
      pass_options
      File.new(error_file,'w+')
      ARGV[0] = error_file
      @shebang.prepend(ARGV[0])
      File.open(error_file).grep(/\#\!/).size.should == 0
    end

    it "should NOT run if shebang line exists" do
      pass_options
      File.new(test_file,'w+')
      ARGV[0] = test_file
      @shebang.prepend(ARGV[0])
      File.open(test_file).grep(/\#\!/).size.should == 1
    end

    it "should accept multiple file arguments" do
      pass_options
      test_file1 = test_file + '1'
      test_file2 = test_file + '2'
      test_file3 = test_file + '3'
      File.new(test_file1,'w+')
      File.new(test_file2,'w+')
      File.new(test_file3,'w+')
      ARGV[0] = test_file1
      ARGV[1] = test_file2
      ARGV[2] = test_file3
      @shebang.prepend(ARGV)
    end

    it "should not overwrite existing file content" do
      pass_options
      File.open(test_file,'w+') do |file|
        file.write "## Author: Andy Bettisworth\n"
        file.write "## Description: Test if AddShebang overwrites file content\n"
      end
      ARGV[0] = test_file
      @shebang.prepend(ARGV[0])
      puts File.open(test_file).readlines =~ /## Author: Andy Bettisworth/
    end

    it "should recursively prepend shebang for directory if -r option is used" do
      pending("TODO")
      pass_options
      FileUtils.rm_rf(test_dir)
      Dir.mkdir(test_dir)
      File.new(test_dir + "/file1",'w+')
      File.new(test_dir + "/file2",'w+')
      File.new(test_dir + "/file3",'w+')
      ARGV[0] = test_dir
      @shebang.prepend(ARGV[0])
      File.open(test_dir + "/file1").readlines[0].should eq("#!/usr/bin/env ruby -w")
      File.open(test_dir + "/file2").readlines[0].should eq("#!/usr/bin/env ruby -w")
      File.open(test_dir + "/file3").readlines[0].should eq("#!/usr/bin/env ruby -w")
    end
  end
end