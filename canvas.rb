#!/usr/bin/env ruby -w
# canvas.rb
# Author: Andy Bettisworth
# Description: Get canvases from ~/.sync/.canvas

require 'optparse'

HOME        = ENV['HOME']
DESKTOP     = "#{HOME}/Desktop"
SYNC_CANVAS = "#{HOME}/.sync/.canvas"

class Canvas

  attr_reader :canvas

  def fetch(*target_canvas)
    if target_canvas.empty?
      ask_for_canvas
      format_canvas!(@canvas)
      get_canvas(@canvas) if canvas_exist?(@canvas)

    elsif target_canvas.length == 1
      @canvas = target_canvas[0]
      format_canvas!(@canvas)
      get_canvas(@canvas) if canvas_exist?(@canvas)

    elsif target_canvas.length > 1
      target_canvas.each do |canvas|
        @canvas = canvas
        format_canvas!(@canvas)
        get_canvas(@canvas) if canvas_exist?(@canvas)
      end
    end
  end

  def clean
    all_canvas = Array.new
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

  def get_canvas(canvas)
    system("cp #{SYNC_CANVAS}/#{@canvas} #{DESKTOP}")
  end

  def ask_for_canvas
    while @canvas.nil?
      puts "What canvas do you want?"
      @canvas = gets.strip
    end
  end

  def canvas_exist?(canvas)
    if File.exist?("#{SYNC_CANVAS}/#{canvas}")
      true
    else
      puts "WARNING: No such canvas exists: '#{canvas}'"
      false
    end
  end

  def format_canvas!(canvas)
    @canvas += ".rb" unless canvas.match(/\.\w.*/)
  end
end

options = {}
OptionParser.new do |opts|
  opts.banner = "USAGE: canvas [FILE]"

  opts.on('--clean' 'Put away all open canvases') do
    options[:clean] = true
  end
end.parse!

## USAGE
secretary = Canvas.new
if options[:clean] == true
  secretary.clean
else
  ARGV.each do |arg|
    secretary.fetch(arg)
  end
end

# describe Canvas do
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
#       if File.exist?("#{SYNC_CANVAS}/canvas_test#{i}.py")
#         File.delete("#{SYNC_CANVAS}/canvas_test#{i}.py")
#       end
#       if File.exist?("#{DESKTOP}/canvas_test#{i}.rb")
#         File.delete("#{DESKTOP}/canvas_test#{i}.rb")
#       end
#       if File.exist?("#{DESKTOP}/canvas_test#{i}.py")
#         File.delete("#{DESKTOP}/canvas_test#{i}.py")
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
#   end

#   describe "#clean" do
#     it "should put away all canvas on Desktop" do
#       pending "canvas.rb the script gets in the way of this test."
#       getter = Canvas.new
#       getter.clean
#       getter.fetch("canvas_test1.rb")
#       expect(File.exist?("#{DESKTOP}/canvas_test1.rb")).to be_false
#       expect(File.exist?("#{SYNC_CANVAS}/canvas_test1.rb")).to be_true
#     end
#   end
# end
