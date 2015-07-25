#!/usr/bin/env ruby
# admin.rb
# Author: Andy Bettisworth
# Created At: 2015 0528 044634
# Modified At: 2015 0528 044634
# Description: system administration module

require 'fileutils'

module Admin
  HOME     = ENV['HOME']
  DESKTOP  = "#{HOME}/Desktop"
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

  def require_file(file_path)
    unless File.exist?(file_path)
      raise LoadError, "No such file at '#{file_path}'"
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
    puts "What file do you want?"
    filequery = gets.split(/\s.*?/).flatten
    filequery
  end

  def append_default_ext(*files)
    files.flatten!
    files.collect! { |f| f += '.rb' if File.extname(f) == ""; f }
    return files.count <= 1 ? files[0] : files
  end

  def find_matching_files(query, files)
    matches = []
    files.each do |d|
      matches << d if query.include?(File.basename(d))
    end
    matches
  end
end
