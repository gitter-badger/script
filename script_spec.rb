#!/usr/bin/env ruby -w
# script.rb
# Author: Andy Bettisworth
# Description: Get scripts from ~/.sync/.script

require 'optparse'

HOME = ENV['HOME']
DESKTOP = "#{HOME}/Desktop"
SYNC_SCRIPT = "#{HOME}/.sync/.script"

class Script

  attr_reader :script

  def fetch(*scripts)
    if scripts.empty?
      puts "What script do you want?"
      @script = gets.strip
      format_script!(@script)
      fail "No such script exists: '#{@script}'" unless script_exist?(@script)
      @script = format_script!(@script)
      system("cp #{SYNC_SCRIPT}/#{@script} #{DESKTOP}")
    elsif scripts.length == 1
      @script = scripts[0]
      format_script!(@script)
      fail "No such script exists: '#{@script}'" unless script_exist?(@script)
      system("cp #{SYNC_SCRIPT}/#{@script} #{DESKTOP}")
    elsif scripts.length > 1
      scripts.each do |script|
        @script = script
        format_script!(@script)
        fail "No such script exists: '#{@script}'" unless script_exist?(@script)
        system("cp #{SYNC_SCRIPT}/#{@script} #{DESKTOP}")
      end
    end
  end

  def clean
    all_scripts = Array.new
    Dir.foreach("#{SYNC_SCRIPT}") do |script|
      next if File.directory?(script)
      next unless script.include?(".rb")
      all_scripts << script
    end

    Dir.foreach("#{DESKTOP}") do |open_script|
      next if File.directory?(open_script)
      next unless open_script.include?(".rb")
      system("mv #{DESKTOP}/#{open_script.to_s} #{SYNC_SCRIPT}") if all_scripts.include?(open_script)
    end
  end

  private
  def script_exist?(script)
    File.exist?("#{SYNC_SCRIPT}/#{script}")
  end

  def format_script!(script)
    @script += ".rb" unless script.include?(".rb")
  end
end

options = {}
OptionParser.new do |opts|
  opts.on("--fetch", 'Move target scripts to Desktop') do
    options[:fetch] = true
  end

  opts.on("--clean", 'Put away all open scripts') do
    options[:clean] = true
  end
end.parse!

## USAGE
# secretary = Script.new
# if options[:clean] == true
#   secretary.clean
# else
#   ARGV.each do |arg|
#     secretary.fetch arg
#   end
# end

describe Script do
  before(:each) do
    File.open("#{SYNC_SCRIPT}/test1.rb",'w+')
    File.open("#{SYNC_SCRIPT}/test3.rb",'w+')
    File.open("#{SYNC_SCRIPT}/test2.rb",'w+')
  end

  after(:each) do
    if File.exist?("#{SYNC_SCRIPT}/test1.rb")
      File.delete("#{SYNC_SCRIPT}/test1.rb")
    end
    if File.exist?("#{SYNC_SCRIPT}/test2.rb")
      File.delete("#{SYNC_SCRIPT}/test2.rb")
    end
    if File.exist?("#{SYNC_SCRIPT}/test3.rb")
      File.delete("#{SYNC_SCRIPT}/test3.rb")
    end
    if File.exist?("#{DESKTOP}/test1.rb")
      File.delete("#{DESKTOP}/test1.rb")
    end
    if File.exist?("#{DESKTOP}/test2.rb")
      File.delete("#{DESKTOP}/test2.rb")
    end
    if File.exist?("#{DESKTOP}/test3.rb")
      File.delete("#{DESKTOP}/test3.rb")
    end
  end

  describe "#fetch" do
    it "should move target scripts to Desktop" do
      getter = Script.new
      getter.fetch "test1.rb"
      expect(File.exist?("#{DESKTOP}/test1.rb")).to be_true
    end

    it "should accept an Array of scripts" do
      getter = Script.new
      getter.fetch("test1.rb", "test2.rb", "test3.rb")
      expect(File.exist?("#{DESKTOP}/test1.rb")).to be_true
      expect(File.exist?("#{DESKTOP}/test2.rb")).to be_true
      expect(File.exist?("#{DESKTOP}/test3.rb")).to be_true
    end

    it "should ask for script if no argument provided" do
      pending("TODO, add a stub for gets()")
      getter = Script.new
      getter.fetch
      STDIN.should_receive(:read).and_return("test1.rb")
      expect(File.exist?("#{DESKTOP}/test1.rb")).to be_true
    end

    it "should accept script without extension '.rb'" do
      getter = Script.new
      getter.fetch "test1"
      expect(File.exist?("#{DESKTOP}/test1.rb")).to be_true
    end
  end

  describe "#clean" do
    it "should put away all scripts on Desktop", wip: true do
      getter = Script.new
      getter.clean
      getter.fetch("test1.rb", "test2.rb", "test3.rb")
      expect(File.exist?("#{DESKTOP}/test1.rb")).to be_false
      expect(File.exist?("#{DESKTOP}/test2.rb")).to be_false
      expect(File.exist?("#{DESKTOP}/test3.rb")).to be_false
    end
  end
end
