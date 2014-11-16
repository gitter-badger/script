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

  def list(canvas_regexp=false, lang_regexp=false)
    lang_dir = get_lang_dir(lang_regexp)
    canvases = get_canvases(lang_dir)
    canvases = filter_canvases(canvases, canvas_regexp)
    canvases = canvases.sort_by { |k,v| k[:filename]}
    print_canvas_list(canvases)
    canvases
  end

  def add(canvas)
    raise 'CanvasExistsError: A canvas by that name already exists.' if canvas_exist?(canvas)
    create_canvas(canvas)
  end

  def fetch(*canvases)
    canvases = ask_for_canvas while canvases.flatten.empty?
    canvases = set_default_ext(canvases)
    canvases = set_default_prefix(canvases)
    canvases = get_canvas_location(canvases)
    move_canvas_to_desktop(canvases)
  end

  def info(canvas)
    canvas = set_default_ext(canvas)
    if canvas_exist?(canvas)
      canvas = get_canvas_info(canvas)
      print_canvas_info(canvas)
    else
      STDERR.puts "NoSuchCanvasError: Did not find canvas '#{canvas}'"
      exit 1
    end
  end

  def clean
    lang_dir = get_lang_dir
    canvases = get_canvases(lang_dir)
    canvases.collect! { |c| c[:filename] }
    clean_off_desktop(canvases)
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
        canvas_list << canvas
      end
    end
    canvas_list
  end

  # > use lang arg to filter options, if provided
  def get_lang_dir(lang_regexp=false)
    lang_dir = []

    Dir.foreach(CANVAS) do |lang|
      next unless File.directory?(File.join(CANVAS, lang))
      next if lang == '.' or lang == '..' or lang == '.git'
      lang_dir << File.join(CANVAS, lang)
    end

    lang_dir
  end

  def get_canvas_info(filepath)
    canvas = {}

    file_head = File.open(filepath).readlines
    c = file_head[0..11].join('')

    if c.valid_encoding?
      canvas[:filename] = File.basename(filepath)

      created_at = /created at:(?<created_at>.*)/i.match(c.force_encoding('UTF-8'))
      canvas[:created_at] = created_at[:created_at].strip if created_at

      modified_at = /modified at:(?<modified_at>.*)/i.match(c.force_encoding('UTF-8'))
      canvas[:modified_at] = modified_at[:modified_at].strip if modified_at

      description = /description:(?<description>.*)/i.match(c.force_encoding('UTF-8'))
      canvas[:description] = description[:description].strip if description
    else
      puts "ERROR: Not valid UTF-8 encoding in '#{File.basename(filepath)}'"
    end

    canvas
  end

  def filter_canvases(canvases, canvas_regexp=false)
    pattern = Regexp.new(canvas_regexp) if canvas_regexp
    canvases.select! { |c| pattern.match(c[:filename]) } if pattern
    canvases
  end

  def print_canvas_list(canvases)
    canvases.each do |canvas|
      space = 31 - canvas[:filename].length if canvas[:filename].length < 31
      space ||= 1
      puts "#{canvas[:filename].gsub('canvas_', '')} #{' ' * space} #{canvas[:description]}"
    end
  end

  def print_canvas_info(canvas)
    puts "filename:     #{canvas[:filename]}"
    puts "author:       #{canvas[:author]}"
    puts "created_at:   #{canvas[:created_at]}"
    puts "modified_at:  #{canvas[:modified_at]}"
    puts "description:  #{canvas[:description]}"
    puts "dependencies: #{canvas[:dependencies]}"
  end

  def create_canvas(canvas)
    canvas = set_default_ext(canvas)
    canvas = default_prefix(canvas)

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

  def set_default_ext(*canvases)
    canvases.flatten!
    canvases.collect! do |canvas|
      if File.extname(canvas) == ""
        canvas += '.rb'
      end
      canvas
    end

    if canvases.count <= 1
      return canvases[0]
    else
      return canvases
    end
  end

  def set_default_prefix(*canvases)
    canvases.flatten!
    canvases.collect! do |canvas|
      unless /canvas_/.match(canvas)
        canvas = 'canvas_' + canvas
      end
      canvas
    end

    if canvases.count <= 1
      return canvases[0]
    else
      return canvases
    end
  end

  def get_canvas_location(*canvases)
    canvases.flatten!
    canvases.collect! do |canvas|
      lang = ALIAS_CMD[File.extname(canvas)]

      if lang
        "#{CANVAS}/#{lang}/#{canvas}"
      else
        ''
      end
    end

    if canvases.count <= 1
      return canvases[0]
    else
      return canvases
    end
  end

  def move_canvas_to_desktop(*canvases)
    canvases.flatten!
    canvases.each do |canvas|
      if File.exist?(canvas)
        system("cp #{canvas} #{DESKTOP}")
      else
        puts "No such canvas: '#{File.basename(canvas)}'"
      end
    end
  end

  def get_shebang(ext)
    shebang = SHEBANGS[ext]
    shebang
  end

  def ask_for_canvas
    canvas_list = []
    puts "What canvas do you want? [fiber matplotlib.py expect.rb]"
    puts "Note default extension is Ruby (.rb)"
    canvases = gets.split(/\s.*?/).flatten
    canvases.each { |c| canvas_list << c }
    canvas_list
  end

  def canvas_exist?(canvas)
    lang_dir = get_lang_dir
    canvases = get_canvases(lang_dir)
    puts canvases.count
    # canvases.select! { |c| c[:filename] == canvas }
    # puts "#{canvas} #{canvases.count}"

    if canvases.count >= 1
      true
    else
      false
    end
  end

  def clean_off_desktop(*canvases)
    canvases.flatten!
    Dir.foreach("#{DESKTOP}") do |file|
      next if File.directory?(file)
      location = get_canvas_location(file)
      system("mv #{DESKTOP}/#{file.to_s} #{location}") if canvases.include?(file)
    end
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

    opts.on('-l [REGXP]', '--list [REGXP]', 'List all canvases, with optional pattern matching') do |regexp|
      options[:list] = true
      options[:canvas_pattern] = regexp
      options[:lang_pattern] = regexp
    end

    opts.on('-n CANVAS', '--new CANVAS', 'Create a canvas') do |c|
      options[:add] = c
    end

    opts.on('-f', '--fetch', 'Copy canvas(es) to the Desktop') do
      options[:fetch] = true
    end

    opts.on('--info SCRIPT', 'Show script information') do |script|
      options[:info] = script
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
    c.list(options[:canvas_pattern], options[:lang_pattern])
  elsif options[:add]
    c.add(options[:add])
  elsif options[:fetch]
    c.fetch(ARGV)
  elsif options[:info]
    c.info(options[:info])
  elsif options[:clean]
    c.clean
  elsif options[:history]
    c.history
  else
    puts option_parser
  end
end
