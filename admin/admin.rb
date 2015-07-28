#!/usr/bin/env ruby
# admin.rb
# Author: Andy Bettisworth
# Created At: 2015 0528 044634
# Modified At: 2015 0528 044634
# Description: system administration module

require 'fileutils'
require 'pathname'

module Admin
  HOME     = ENV['HOME']
  DESKTOP  = "#{HOME}/Desktop"
  DEFAULT_EXT = '.rb'
  BINARIES = {
    '.c'   => 'gcc',
    '.rb'  => 'ruby',
    '.py'  => 'python',
    '.exp' => 'expect',
    '.js'  => 'node',
    '.sh'  => 'bash'
  }
  DEPENDENCIES = {
    '.c'  => Regexp.new(/include.*?\s\'(?<dependency>.*)\'/i),
    '.rb' => Regexp.new(/require.*?\s\'(?<dependency>.*)\'/i),
    '.py' => Regexp.new(/import.*?\s(?<dependency>.*)/i)
  }
  COMMENTS = {
    '.c'   => '//',
    '.rb'  => '#',
    '.py'  => '#',
    '.exp' => '#',
    '.js'  => '//',
    '.sh'  => '#'
  }

  def require_file(pathname)
    unless File.exist?(pathname)
      raise LoadError, "No such file at '#{pathname}'"
    end
  end

  def require_dir(pathname)
    unless File.exist?(pathname)
      raise LoadError, "No such directory at #{pathname}"
    end
  end

  def grab_all_files(dirname = '.')
    files = []

    Dir["#{dirname}/**/*"].each do |file|
      next if file == '.' || file == '..' || File.directory?(file)
      files << file
    end

    files
  end

  def filter_files(files, query)
    pattern = Regexp.new(query, Regexp::IGNORECASE)
    files = files.select! { |f| pattern.match(f) }
    files
  end

  def print_files(list)
    list.each do |item|
      puts File.basename(item)
    end
  end

  def copy_files(files, destination)
    files.each do |file|
      FileUtils.copy(file, destination)
    end
  end

  def move_files(files, destination)
    files.each do |file|
      FileUtils.mv(file, destination)
    end
  end

  def ask_for_file
    puts "What file(s) do you want?"
    filequery = gets.split(/\s.*?/).flatten
    filequery
  end

  def append_default_ext(*files)
    files.flatten!
    files.collect! { |f| f += DEFAULT_EXT if File.extname(f) == ""; f }
    return files.count <= 1 ? files[0] : files
  end

  def find_matching_files(query, files)
    matches = []
    query.each do |q|
      pattern = Regexp.new(q, Regexp::IGNORECASE)
      files.each { |f| matches << f if pattern.match(File.basename(f)) }
    end
    matches
  end

  def map_files(dir)
    files = Dir[dir + "/**/*"]
    files.delete_if { |path| File.directory?(path) }
    files.map! { |path| [File.basename(path), path] }
    files = files.to_h
    files
  end

  def dir_diff(from, to)
    from_files = map_files(from)
    to_files   = map_files(to)

    from_files.each do |file, path|
      from_files.delete(file) if to_files.has_key?(file)
    end

    from_files
  end

  def sync_diff(diff, target, source)
    diff.each do |filename, pathname|
      puts "pathname #{ split_path(pathname).inspect }"
      # target_path = File.dirname(pathname).gsub(/^#{source}/, target)
      # find_or_create_directory(target_path)
      # FileUtils.cp(pathname, target_path)
    end
    puts "target #{ target }"
    puts "source #{ source }"
  end

  def find_or_create_directory(pathname)
    FileUtils.mkdir_p(pathname)
  end

  def split_path(path)
    Pathname(path).each_filename.to_a
  end
end
