#!/usr/bin/env ruby -w
# canvas.rb
# Author: Andy Bettisworth
# Description: Get canvases from ~/.sync/.canvas

require 'optparse'

HOME = ENV['HOME']
DESKTOP = "#{HOME}/Desktop"
SYNC_CANVAS = "#{HOME}/.sync/.canvas"

class GetCanvas

  attr_reader :canvas

  def fetch(*canvases)
    if canvases.empty?
      puts "What canvas do you want?"
      @canvas = gets.strip
      format_canvas!(@canvas)
      fail "No such canvas exists: '#{@canvas}'" unless canvas_exist?(@canvas)
      @canvas = format_canvas!(@canvas)
      system("cp #{SYNC_CANVAS}/#{@canvas} #{DESKTOP}")
    elsif canvases.length == 1
      @canvas = canvases[0]
      format_canvas!(@canvas)
      fail "No such canvas exists: '#{@canvas}'" unless canvas_exist?(@canvas)
      system("cp #{SYNC_CANVAS}/#{@canvas} #{DESKTOP}")
    elsif canvases.length > 1
      canvases.each do |canvas|
        @canvas = canvas
        format_canvas!(@canvas)
        fail "No such canvas exists: '#{@canvas}'" unless canvas_exist?(@canvas)
        system("cp #{SYNC_CANVAS}/#{@canvas} #{DESKTOP}")
      end
    end
  end

  def clean
    all_canvases = Array.new
    Dir.foreach("#{SYNC_CANVAS}") do |canvas|
      next if File.directory?(canvas)
      next unless canvas.include?(".rb")
      all_canvases << canvas
    end

    Dir.foreach("#{DESKTOP}") do |open_canvas|
      next if File.directory?(open_canvas)
      next unless open_canvas.include?(".rb")
      system("mv #{DESKTOP}/#{open_canvas.to_s} #{SYNC_CANVAS}") if all_canvases.include?(open_canvas)
    end
  end

  private
  def canvas_exist?(canvas)
    File.exist?("#{SYNC_CANVAS}/#{canvas}")
  end

  def format_canvas!(canvas)
    @canvas += ".rb" unless canvas.include?(".rb")
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
secretary = GetCanvas.new
if options[:clean] == true
  secretary.clean
else
  ARGV.each do |arg|
    secretary.fetch arg
  end
end

## TEST
# describe GetCanvas do

#   before(:each) do
#     File.open("#{SYNC_CANVAS}/test1.rb",'w+')
#     File.open("#{SYNC_CANVAS}/test3.rb",'w+')
#     File.open("#{SYNC_CANVAS}/test2.rb",'w+')
#   end

#   after(:each) do
#     if File.exist?("#{SYNC_CANVAS}/test1.rb")
#       File.delete("#{SYNC_CANVAS}/test1.rb")
#     end
#     if File.exist?("#{SYNC_CANVAS}/test2.rb")
#       File.delete("#{SYNC_CANVAS}/test2.rb")
#     end
#     if File.exist?("#{SYNC_CANVAS}/test3.rb")
#       File.delete("#{SYNC_CANVAS}/test3.rb")
#     end
#     if File.exist?("#{DESKTOP}/test1.rb")
#       File.delete("#{DESKTOP}/test1.rb")
#     end
#     if File.exist?("#{DESKTOP}/test2.rb")
#       File.delete("#{DESKTOP}/test2.rb")
#     end
#     if File.exist?("#{DESKTOP}/test3.rb")
#       File.delete("#{DESKTOP}/test3.rb")
#     end
#   end

#   describe "#fetch" do
#     it "should move target canvases to Desktop" do
#       secretary = GetCanvas.new
#       secretary.fetch "test1.rb"
#       expect(File.exist?("#{DESKTOP}/test1.rb")).to be_true
#     end

#     it "should accept an Array of canvases" do
#       secretary = GetCanvas.new
#       secretary.fetch("test1.rb", "test2.rb", "test3.rb")
#       expect(File.exist?("#{DESKTOP}/test1.rb")).to be_true
#       expect(File.exist?("#{DESKTOP}/test2.rb")).to be_true
#       expect(File.exist?("#{DESKTOP}/test3.rb")).to be_true
#     end

#     it "should ask for canvas if no argument provided" do
#       pending("TODO, add a stub for gets()")
#       secretary = GetCanvas.new
#       secretary.fetch
#       STDIN.should_receive(:read).and_return("test1.rb")
#       expect(File.exist?("#{DESKTOP}/test1.rb")).to be_true
#     end

#     it "should accept canvas without extension '.rb'" do
#       secretary = GetCanvas.new
#       secretary.fetch "test1"
#       expect(File.exist?("#{DESKTOP}/test1.rb")).to be_true
#     end
#   end

#   describe "#clean" do
#     it "should put away all canvases on Desktop", wip: true do
#       secretary = GetCanvas.new
#       secretary.clean
#       secretary.fetch("test1.rb", "test2.rb", "test3.rb")
#       expect(File.exist?("#{DESKTOP}/test1.rb")).to be_false
#       expect(File.exist?("#{DESKTOP}/test2.rb")).to be_false
#       expect(File.exist?("#{DESKTOP}/test3.rb")).to be_false
#     end
#   end
# end
