#!/usr/bin/env ruby -w
# canvas.rb
# Author: Andy Bettisworth
# Description: Get canvases from ~/.sync/.canvas

require 'optparse'

class Canvas
  HOME        = ENV['HOME']
  DESKTOP     = "#{HOME}/Desktop"
  SYNC_CANVAS = "#{HOME}/.sync/.canvas"

  attr_accessor :canvas_list

  def fetch(*canvases)
    @canvas_list = canvases.flatten

    ask_for_canvas while @canvas_list.empty?

    @canvas_list.each_with_index do |target_canvas, index|
      @canvas_list[index] = default_extension(target_canvas)
      @canvas_list[index] = default_prefix(@canvas_list[index])

      if File.exist?("#{SYNC_CANVAS}/#{@canvas_list[index]}")
        get_canvas(@canvas_list[index])
      else
        puts "CanvasNotExistError: #{SYNC_CANVAS}/#{@canvas_list[index]}"
      end
    end
  end

  def clean
    all_canvas = []

    Dir.foreach("#{SYNC_CANVAS}") do |canvas|
      next if File.directory?(canvas)
      all_canvas << canvas
    end

    Dir.foreach("#{DESKTOP}") do |open_canvas|
      next if File.directory?(open_canvas)
      system("mv #{DESKTOP}/#{open_canvas.to_s} #{SYNC_CANVAS}") if all_canvas.include?(open_canvas)
    end
  end

  private

  def get_canvas(target_canvas)
    system("cp #{SYNC_CANVAS}/#{target_canvas} #{DESKTOP}")
  end

  def default_prefix(canvas)
    unless /canvas_/.match(canvas)
      canvas = 'canvas_' + canvas
    end
    canvas
  end

  def default_extension(canvas)
    if File.extname(canvas) == ""
      canvas += '.rb'
    end
    canvas
  end

  def ask_for_canvas
    puts "What canvas do you want?"
    @canvas_list < gets
  end

  def canvas_exist?
    if File.exist?("#{SYNC_CANVAS}/#{canvas}")
      true
    else
      puts "WARNING: No such canvas exists: '#{canvas}'"
      false
    end
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = "USAGE: canvas [FILE]"

  opts.on('-f', '--fetch', 'Copy canvas(es) to the Desktop') do
    options[:fetch] = true
  end

  opts.on('-c', '--clean', 'Move canvas(es) back into ~/.sync') do
    options[:clean] = true
  end
end
option_parser.parse!

## USAGE
canvas_dispatcher = Canvas.new
if options[:clean] == true
  canvas_dispatcher.clean
elsif options[:fetch]
  canvas_dispatcher.fetch(ARGV)
else
  puts option_parser
end

# describe Canvas do
#   HOME        = ENV['HOME']
#   DESKTOP     = "#{HOME}/Desktop"
#   SYNC_CANVAS = "#{HOME}/.sync/.canvas"

#   before(:each) do
#     3.times do |i|
#       File.open("#{SYNC_CANVAS}/canvas_test#{i}.rb",'w+')
#       File.open("#{SYNC_CANVAS}/canvas_test#{i}.py",'w+')
#     end
#   end

#   after(:each) do
#     3.times do |i|
#       if File.exist?("#{SYNC_CANVAS}/canvas_test#{i}.rb")
#         File.delete("#{SYNC_CANVAS}/canvas_test#{i}.rb")
#       end
#     end
#   end

#   describe "#fetch" do
#     it "should move target canvas to ~/Desktop" do
#       getter = Canvas.new
#       getter.fetch "canvas_test1.rb"
#       expect(File.exist?("#{DESKTOP}/canvas_test1.rb")).to be_true
#     end

#     it "should accept an Array of canvases" do
#       getter = Canvas.new
#       getter.fetch("canvas_test0.rb", "canvas_test1.rb", "canvas_test2.rb")
#       expect(File.exist?("#{DESKTOP}/canvas_test0.rb")).to be_true
#       expect(File.exist?("#{DESKTOP}/canvas_test1.rb")).to be_true
#       expect(File.exist?("#{DESKTOP}/canvas_test2.rb")).to be_true
#     end

#     it "should ask for canvas if no argument provided" do
#       pending "stub the ask return value"
#       getter = Canvas.new
#       expect(getter).to receive(:puts).with('What canvas do you want?')
#       getter.fetch
#     end

#     it "should accept canvas without extension '.rb'" do
#       getter = Canvas.new
#       getter.fetch "canvas_test1"
#       expect(File.exist?("#{DESKTOP}/canvas_test1.rb")).to be_true
#     end

#     it "should accept multiple filetypes" do
#       getter = Canvas.new
#       getter.fetch "canvas_test1.py"
#       expect(File.exist?("#{DESKTOP}/canvas_test1.py")).to be_true
#     end

#     it "should not require the appended 'canvas_'" do
#       getter = Canvas.new
#       getter.fetch "test1.rb"
#       expect(File.exist?("#{DESKTOP}/canvas_test1.rb")).to be_true
#     end
#   end

#   describe "#clean" do
#     it "should put away all canvas on Desktop" do
#       getter = Canvas.new
#       getter.fetch("canvas_test1.rb")
#       getter.clean
#       expect(File.exist?("#{DESKTOP}/canvas_test1.rb")).to be_false
#       expect(File.exist?("#{SYNC_CANVAS}/canvas_test1.rb")).to be_true
#     end
#   end
# end
