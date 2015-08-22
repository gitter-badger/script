#!/usr/bin/env ruby -w
# canvas.rb
# Author: Andy Bettisworth
# Created At: 2015 0528 033952
# Modified At: 2015 0528 033955
# Description: Manage local canvases

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Admin
  # manage all local canvases
  class Canvas
    CANVAS_DIR = File.join(HOME, 'GitHub', 'canvas')
    SHEBANGS   = {
      '.c'   => '//',
      '.rb'  => '#!/usr/bin/env ruby -w',
      '.py'  => '#!/usr/bin/env python',
      '.exp' => '#!/usr/bin/env expect',
      '.js'  => '#!/usr/bin/env node',
      '.sh'  => '#!/bin/bash'
    }
    BOILERPLATE = <<-TXT
$0
$C $1
$C Author: Andy Bettisworth
$C Created At: $2
$C Modified At: $3
$C Description: $4
    TXT

    def list(canvas_regexp=false)
      lang_dir = get_lang_dir
      canvases = get_canvases(lang_dir)
      canvases = filter_canvases(canvases, canvas_regexp) if canvas_regexp
      canvases = canvases.sort_by { |k,v| k[:filename] }
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
      canvas = set_default_prefix(canvas)

      if canvas_exist?(canvas)
        canvas = get_canvas_location(canvas)
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
      canvases_out = get_open_canvases(canvases)
      canvases_out = get_canvas_location(canvases_out)

      if canvases_out
        if canvases_out.is_a? Array
          canvases_out.each do |s|
            FileUtils.mv(File.join(DESKTOP, File.basename(s)), s)
          end
        else
          FileUtils.mv(File.join(DESKTOP, File.basename(canvases_out)), canvases_out)
        end

        commit_changes
      end
    end

    def sync
      commit_changes
      sync_github(CANVAS_DIR)
    end

    def history
      files = `cd #{CANVAS_DIR}; git diff --name-status "@{7 days ago}" "@{0 days ago}"`
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

    private

    def get_canvases(lang_dir)
      canvas_list = []

      lang_dir.each do |lang|
        target_lang = lang
        Dir.foreach(File.join(CANVAS_DIR, target_lang)) do |file|
          next if file == '.' or file == '..'
          canvas = {}
          canvas = get_canvas_info(File.join(CANVAS_DIR, target_lang, file))
          canvas_list << canvas
        end
      end

      canvas_list
    end

    def get_open_canvases(canvases)
      open_canvases = []

      Dir.foreach(DESKTOP) do |entry|
        next if File.directory?(entry)
        open_canvases << entry if canvas_exist?(entry)
      end

      open_canvases
    end

    def get_lang_dir
      language = []

      Dir.foreach(CANVAS_DIR) do |entry|
        next unless File.directory?(File.join(CANVAS_DIR, entry))
        next if entry == '.' or entry == '..' or entry == '.git'
        language << entry
      end

      language
    end

    def get_canvas_info(filepath)
      canvas = {}

      dirname  = File.dirname(filepath)
      top_path = File.expand_path('..', dirname)
      language = dirname.gsub("#{top_path}/", '')

      f = File.open(filepath)
      file_head = f.readlines
      c = file_head[0..11].join('')
      f.close

      if c.valid_encoding?
        canvas[:language] = language
        canvas[:filename] = File.basename(filepath)

        created_at = /created at:(?<created_at>.*)/i.match(c.force_encoding('UTF-8'))
        canvas[:created_at] = created_at[:created_at].strip if created_at

        modified_at = /modified at:(?<modified_at>.*)/i.match(c.force_encoding('UTF-8'))
        canvas[:modified_at] = modified_at[:modified_at].strip if modified_at

        description = /description:(?<description>.*)/i.match(c.force_encoding('UTF-8'))
        canvas[:description] = description[:description].strip if description
      else
        STDERR.puts "ERROR: Not valid UTF-8 encoding in '#{File.basename(filepath)}'"
        exit 1
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
    end

    def create_canvas(canvas)
      canvas  = set_default_ext(canvas)
      canvas  = set_default_prefix(canvas)
      extname = File.extname(canvas)

      language = BINARIES[extname]
      unless language
        STDERR.puts "Unknown extension '#{extname}'"
        STDERR.puts "Possible extensions include: #{BINARIES.keys.join(' ')}"
        exit 1
      end

      puts 'Describe this canvas: '
      description = gets
      description ||= '...'

      header = BOILERPLATE.gsub!('$C', COMMENTS[extname])
      header = BOILERPLATE.gsub!('$0', get_shebang(extname))
      header = header.gsub!('$1', canvas)
      header = header.gsub!('$2', Time.now.strftime('%Y %m%d %H%M%S'))
      header = header.gsub!('$3', Time.now.strftime('%Y %m%d %H%M%S'))
      header = header.gsub!('$4', description)

      File.new(File.join(CANVAS_DIR, language, canvas), 'w+') << header
      File.new(File.join(DESKTOP, canvas), 'w+') << header
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
      lang_dir    = get_lang_dir
      canvas_list = get_canvases(lang_dir)

      canvases.flatten!
      canvases.collect! do |canvas|
        canvas = set_default_ext(canvas)
        canvas = set_default_prefix(canvas)
        cl = canvas_list.select { |c| c[:filename] == canvas }

        if cl.count >= 1
          File.join(CANVAS_DIR, cl[0][:language], canvas)
        else
          canvas
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
          FileUtils.cp(canvas, DESKTOP)
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
      canvas = set_default_ext(canvas)
      canvas = set_default_prefix(canvas)

      lang_dir = get_lang_dir
      canvases = get_canvases(lang_dir)
      canvases.select! { |c| c[:filename] == canvas }

      if canvases.count >= 1
        true
      else
        false
      end
    end

    def commit_changes
      puts 'Enter a commit message:'
      commit_msg = gets.strip
      commit_msg = "canvas clean #{Time.now.strftime('%Y%m%d%H%M%S')}" if commit_msg == ""
      puts ''
      puts 'Committing changes for canveses...'
      Dir.chdir(CANVAS_DIR)
      system('git checkout annex')
      system('git add -A')
      system('git commit -m "' + commit_msg + '"')
    end

    def branch_exist?(repository, branch)
      Dir.chdir repository
      branches = `git branch`
      return branches.include?(branch)
    end

    def remote_exist?(repository, branch)
      Dir.chdir repository
      remotes = `git remote -v`
      return remotes.include?(branch)
    end

    def sync_github(repo_path)
      raise "MissingBranch: No branch named 'master'" unless branch_exist?(repo_path, 'master')
      raise "MissingBranch: No branch named 'annex'"  unless branch_exist?(repo_path, 'annex')
      raise "MissingBranch: No remote named 'github'" unless remote_exist?(repo_path, 'github')
      system <<-CMD
        cd #{repo_path}
        git checkout master
        git merge annex
        git pull --no-edit github master
        git push github master
        git checkout annex
        git merge --no-edit master
      CMD
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: canvas [options] FILE'

    opts.on('-l', '--list [REGXP]', 'List matching canvases') do |regexp|
      options[:list] = true
      options[:list_regexp] = regexp
    end

    opts.on('-n', '--new CANVAS', 'Create a new canvas') do |name|
      options[:add] = name
    end

    opts.on('-f', '--fetch', 'Copy matching canvas(es) to Desktop') do
      options[:fetch] = true
    end

    opts.on('--info CANVAS', 'Show canvas header information') do |canvas|
      options[:info] = canvas
    end

    opts.on('--clean', 'Move canvas(es) off Desktop and commit changes') do
      options[:clean] = true
    end

    opts.on('--sync', 'Commit any changes and attempt a GitHub sync') do
      options[:sync] = true
    end

    opts.on('--history', 'List recent canvas activity') do
      options[:history] = true
    end
  end
  option_parser.parse!

  canvas = Canvas.new

  if options[:list]
    canvas.list(options[:list_regexp])
    exit 0
  elsif options[:add]
    canvas.add(options[:add])
    exit 0
  elsif options[:fetch]
    canvas.fetch(ARGV)
    exit 0
  elsif options[:info]
    canvas.info(options[:info])
    exit 0
  elsif options[:clean]
    canvas.clean
    exit 0
  elsif options[:sync]
    canvas.sync
    exit 0
  elsif options[:history]
    canvas.history
    exit 0
  else
    puts option_parser
    exit 1
  end
end
