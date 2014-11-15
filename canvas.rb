#!/usr/bin/env ruby -w
# canvas.rb
# Author: Andy Bettisworth
# Description: Canvas Management Class

require 'optparse'

class Canvas
  DESKTOP     = "#{ENV['HOME']}/Desktop"
  CANVAS      = "#{ENV['HOME']}/.sync/.canvas"
  ALIAS_CMD = {
    '.rb'  => 'ruby',
    '.py'  => 'python',
    '.exp' => 'expect',
    '.sh'  => 'bash'
  }
  SHEBANGS = {
    '.rb'  => '#!/usr/bin/env ruby -w',
    '.py'  => '#!/usr/bin/env python',
    '.exp' => '#!/usr/bin/env expect',
    '.sh'  => '#!/bin/bash'
  }
  BOILERPLATE = <<-TXT
$0
# $1
# Author: Andy Bettisworth
# Created At: $2
# Modified At: $3
# Description: $4
  TXT

  attr_accessor :canvas_list

  def list(regexp, lang=false)
    pattern = Regexp.new(regexp) if regexp

    lang_dir = get_lang_dir(lang)
    canvas_list = get_canvases(lang_dir)
    canvas_list.select! { |c| pattern.match(c[:filename]) } if pattern

    canvas_list.each do |canvas|
      space = 31 - canvas[:filename].length if canvas[:filename].length < 31
      space ||= 1
      puts "#{canvas[:filename].gsub('canvas_', '')} #{' ' * space} #{canvas[:description]}"
    end
    canvas_list
  end

  def add(canvas)
    raise 'CanvasExistsError: A canvas by that name already exists.' if canvas_exist?(canvas)
    create_canvas(canvas)
  end

  def fetch_all(*canvases)
    @canvas_list = canvases.flatten
    ask_for_canvas while @canvas_list.empty?

    @canvas_list.each_with_index do |target_canvas, index|
      @canvas_list[index] = default_extension(target_canvas)
      @canvas_list[index] = default_prefix(@canvas_list[index])

      if File.exist?("#{CANVAS}/#{@canvas_list[index]}")
        fetch(@canvas_list[index])
      else
        raise "CanvasNotExistError: #{CANVAS}/#{@canvas_list[index]}"
      end
    end
  end

  def clean
    all_canvas = []

    Dir.foreach("#{CANVAS}") do |canvas|
      next if File.directory?(canvas)
      all_canvas << canvas
    end

    Dir.foreach("#{DESKTOP}") do |open_canvas|
      next if File.directory?(open_canvas)
      system("mv #{DESKTOP}/#{open_canvas.to_s} #{CANVAS}") if all_canvas.include?(open_canvas)
    end

    sync
  end

  def history
    files = `cd #{CANVAS}; git diff --name-status "@{7 days ago}" "@{0 days ago}"`
    files = files.split("\n")
    puts "7-Day Canvas Activity:"

    canvases = {}
    files.each do |f|
      filename = f[1..-1].strip
      canvases[filename] = f[0]
    end

    added_canvases    = canvases.select { |s,a| a == "A"}
    modified_canvases = canvases.select { |s,a| a == "M"}
    deleted_canvases  = canvases.select { |s,a| a == "D"}
    puts ""
    puts "#{added_canvases.count} canves(es) added: "
    added_canvases.each { |c,a| puts "  #{c}" }
    puts ""
    puts "#{modified_canvases.count} canves(es) modified: "
    modified_canvases.each { |c,a| puts "  #{c}" }
    puts ""
    puts "#{deleted_canvases.count} canves(es) deleted: "
    deleted_canvases.each { |c,a| puts "  #{c}" }
  end

  def get_canvases(lang_dir)
    canvas_list = []

    lang_dir.each do |lang|
      target_lang = lang
      Dir.foreach(target_lang) do |file|
        next if file == '.' or file == '..'
        canvas = {}
        canvas = get_canvas_info("#{target_lang}/#{file}")
        puts "#{canvas[:filename]}   #{canvas[:description]}"
        canvas_list << canvas
      end
    end

    canvas_list
  end

  # > use lang arg to filter options, if provided
  def get_lang_dir(lang)
    lang_dir = []
    Dir.foreach(CANVAS) do |lang|
      next unless File.directory?(File.join(CANVAS, lang))
      next if lang == '.' or lang == '..' or lang == '.git'
      lang_dir << File.join(CANVAS, lang)
    end
    lang_dir
  end

  def get_canvas_info(file)
    canvas = {}

    file_head = File.open(File.join(CANVAS, file)).readlines
    c = file_head[0..11].join('')

    if c.valid_encoding?
      canvas[:filename] = file

      created_at = /created at:(?<created_at>.*)/i.match(c.force_encoding('UTF-8'))
      canvas[:created_at] = created_at[:created_at].strip if created_at

      modified_at = /modified at:(?<modified_at>.*)/i.match(c.force_encoding('UTF-8'))
      canvas[:modified_at] = modified_at[:modified_at].strip if modified_at

      description = /description:(?<description>.*)/i.match(c.force_encoding('UTF-8'))
      canvas[:description] = description[:description].strip if description
    else
      puts "ERROR: Not valid UTF-8 encoding in '#{file}'"
    end

    canvas
  end

  def create_canvas(canvas)
    canvas = default_prefix(canvas)
    canvas = default_extension(canvas)

    puts 'Describe this canvas: '
    description = gets
    description ||= '...'

    header = BOILERPLATE.gsub!('$0', get_shebang(File.extname(canvas)))
    header = header.gsub!('$1', canvas)
    hedaer = header.gsub!('$2', Time.now.strftime('%Y %m%d %H%M%S'))
    hedaer = header.gsub!('$3', Time.now.strftime('%Y %m%d %H%M%S'))
    hedaer = header.gsub!('$4', description)

    File.new("#{DESKTOP}/#{canvas}", 'w+') << header
  end

  def fetch(canvas)
    system("cp #{CANVAS}/#{canvas} #{DESKTOP}")
  end

  def default_prefix(canvas)
    unless /canvas_/.match(canvas)
      canvas = 'canvas_' + canvas
    end
    canvas
  end

  def get_shebang(ext)
    shebang = SHEBANGS[ext]
    shebang
  end

  def default_extension(canvas)
    if File.extname(canvas) == ""
      canvas += '.rb'
    end
    canvas
  end

  def ask_for_canvas
    puts "What canvas do you want? (ex: expect.rb, canvas_matplotlib.py)"
    canvases = gets.split(/\s.*?/).flatten
    canvases.each { |c| @canvas_list << c }
  end

  def canvas_exist?(canvas)
    return if File.exist?("#{CANVAS}/#{canvas}") ? true : false
  end

  def sync
    puts 'Enter a commit message:'
    commit_msg = gets.strip
    commit_msg = "canvas clean #{Time.now.strftime('%Y%m%d%H%M%S')}" if commit_msg == ""
    system <<-CMD
      echo '';
      echo 'Commit changes in ~/.sync/.canvas';
      cd #{CANVAS};
      git checkout annex;
      git add -A;
      git commit -m "#{commit_msg}";
    CMD
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "USAGE: canvas [options] [CANVAS]"

    opts.on('-l [REGXP]', '--list [REGXP]', 'List all matching canvases') do |regexp|
      options[:list] = true
      options[:list_pattern] = regexp
    end

    opts.on('-n CANVAS', '--new CANVAS', 'Create a canvas') do |c|
      options[:add] = c
    end

    opts.on('-f', '--fetch', 'Copy canvas(es) to the Desktop') do
      options[:fetch] = true
    end

    opts.on('--clean', 'Move canvas(es) off Desktop') do
      options[:clean] = true
    end

    opts.on('--history', 'List recent canvas activity') do
      options[:history] = true
    end
  end
  option_parser.parse!

  c = Canvas.new

  if options[:list]
    c.list(options[:list_pattern])
  elsif options[:add]
    c.add(options[:add])
  elsif options[:fetch]
    c.fetch_all(ARGV)
  elsif options[:clean]
    c.clean
  elsif options[:history]
    c.history
  else
    puts option_parser
  end
end
