#!/usr/bin/env ruby -w
# canvas.rb
# Author: Andy Bettisworth
# Description: Canvas Management System

require 'optparse'

class Canvas
  DESKTOP = "#{ENV['HOME']}/Desktop"
  CANVAS_DIR  = "#{ENV['HOME']}/.sync/.canvas"

  attr_accessor :canvas_list

  BOILERPLATE = <<-TXT
#!/usr/bin/env ruby -w
# $1
# Author: Andy Bettisworth
# Description: $2
  TXT

  def add(canvas)
    if canvas_exist?(canvas)
      raise 'CanvasExistsError: A canvas by that name already exists.'
    else
      create_canvas(canvas)
    end
  end

  def fetch(*canvases)
    @canvas_list = canvases.flatten

    ask_for_canvas while @canvas_list.empty?

    @canvas_list.each_with_index do |target_canvas, index|
      @canvas_list[index] = default_extension(target_canvas)
      @canvas_list[index] = default_prefix(@canvas_list[index])

      if File.exist?("#{CANVAS_DIR}/#{@canvas_list[index]}")
        get(@canvas_list[index])
      else
        raise "CanvasNotExistError: #{CANVAS_DIR}/#{@canvas_list[index]}"
      end
    end
  end

  def clean
    all_canvas = []

    Dir.foreach("#{CANVAS_DIR}") do |canvas|
      next if File.directory?(canvas)
      all_canvas << canvas
    end

    Dir.foreach("#{DESKTOP}") do |open_canvas|
      next if File.directory?(open_canvas)
      system("mv #{DESKTOP}/#{open_canvas.to_s} #{CANVAS_DIR}") if all_canvas.include?(open_canvas)
    end

    sync
  end

  private

  def create_canvas(canvas)
    canvas = default_prefix(canvas)
    canvas = default_extension(canvas)

    puts 'Describe this canvas: '
    description = gets
    description ||= '...'
    File.new("#{DESKTOP}/#{canvas}", 'w+') <<  BOILERPLATE.gsub('$1', canvas).gsub('$2', description)
  end

  def get(canvas)
    system("cp #{CANVAS_DIR}/#{canvas} #{DESKTOP}")
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

  def canvas_exist?(canvas)
    return if File.exist?("#{CANVAS_DIR}/#{canvas}") ? true : false
  end

  def sync
    system <<-CMD
      echo '';
      echo 'Commit changes in ~/.sync/.canvas';
      cd #{CANVAS_DIR};
      git checkout annex;
      git add -A;
      git commit -m "canvas_clean-#{Time.now.strftime('%Y%m%d%H%M%S')}";
    CMD
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = "USAGE: canvas [FILE]"

  opts.on('-a CANVAS_DIR', '--add CANVAS_DIR', 'Add canvas') do |c|
    options[:add] = c
  end

  opts.on('-f', '--fetch', 'Copy canvas(es) to the Desktop') do
    options[:fetch] = true
  end

  opts.on('-c', '--clean', 'Sync all canvases') do
    options[:clean] = true
  end
end
option_parser.parse!

## USAGE
c = Canvas.new
if options[:clean]
  c.clean
elsif options[:fetch]
  c.fetch(ARGV)
elsif options[:add]
  c.add(options[:add])
else
  puts option_parser
end
