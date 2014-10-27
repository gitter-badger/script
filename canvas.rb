#!/usr/bin/env ruby -w
# canvas.rb
# Author: Andy Bettisworth
# Description: Canvas Management Class

require 'optparse'

class Canvas
  DESKTOP = "#{ENV['HOME']}/Desktop"
  CANVAS  = "#{ENV['HOME']}/.sync/.canvas"

  attr_accessor :canvas_list

  BOILERPLATE = <<-TXT
#!/usr/bin/env ruby -w
# $1
# Author: Andy Bettisworth
# Description: $2
  TXT

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

  def list(regexp)
    pattern = Regexp.new(regexp) if regexp
    canvas_dict = get_canvases(pattern)
    canvas_dict.each do |name, desc|
      puts "#{name.gsub('canvas_', '')}          #{desc}"
    end
    canvas_dict
  end

  private

  def get_canvases(pattern)
    canvas_dict = {}
    canvas_list = Dir.entries(CANVAS).delete_if do |c|
      File.directory?(File.join(CANVAS, c))
    end
    canvas_list.select! { |s| pattern.match(s) } if pattern
    canvas_list.each do |c|
      d = File.open(File.join(CANVAS, c)).readlines.select! { |l| /description:/i.match(l) }
      begin
        canvas_dict[c] = d[0].gsub(/# description: /i, '')
      rescue
        canvas_dict[c] = ''
      end
    end
    canvas_dict.sort
  end

  def create_canvas(canvas)
    canvas = default_prefix(canvas)
    canvas = default_extension(canvas)

    puts 'Describe this canvas: '
    description = gets
    description ||= '...'
    File.new("#{DESKTOP}/#{canvas}", 'w+') <<  BOILERPLATE.gsub('$1', canvas).gsub('$2', description)
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
    opts.banner = "USAGE: canvas [FILE]"

    opts.on('-n CANVAS', '--new CANVAS', 'Create a canvas') do |c|
      options[:add] = c
    end

    opts.on('-f', '--fetch', 'Copy canvas(es) to the Desktop') do
      options[:fetch] = true
    end

    opts.on('--clean', 'Move canvas(es) off Desktop') do
      options[:clean] = true
    end

    opts.on('-l [REGXP]', '--list [REGXP]', 'List all matching canvases') do |regexp|
      options[:list] = true
      options[:list_pattern] = regexp
    end
  end
  option_parser.parse!

  c = Canvas.new
  if options[:clean]
    c.clean
  elsif options[:fetch]
    c.fetch_all(ARGV)
  elsif options[:add]
    c.add(options[:add])
  elsif options[:list]
    c.list(options[:list_pattern])
  else
    puts option_parser
  end
end