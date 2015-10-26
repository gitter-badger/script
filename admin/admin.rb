#!/usr/bin/env ruby
# admin.rb
# Author: Andy Bettisworth
# Created At: 2015 0528 044634
# Modified At: 2015 0528 044634
# Description: administration module

require 'fileutils'
require 'pathname'

module Admin
  HOME = ENV['HOME']
  DESKTOP = File.join(HOME, 'Desktop')
  DEFAULT_EXT = '.rb'
  BINARIES = {
    '.c'      => 'gcc',
    '.coffee' => 'coffee',
    '.exp'    => 'expect',
    '.go'     => 'go',
    '.js'     => 'node',
    '.py'     => 'python',
    '.rb'     => 'ruby',
    '.sh'     => 'bash'
  }
  DEPENDENCIES = {
    '.c'  => Regexp.new(/include.*?\s\'(?<dependency>.*)\'/i),
    '.py' => Regexp.new(/import.*?\s(?<dependency>.*)/i),
    '.rb' => Regexp.new(/require.*?\s\'(?<dependency>.*)\'/i)
  }
  COMMENTS = {
    '.c'     => '//',
    '.coffee'=> '#',
    '.exp'   => '#',
    '.go'    => '//',
    '.js'    => '//',
    '.py'    => '#',
    '.rb'    => '#',
    '.sh'    => '#'
  }
  SHEBANGS   = {
    '.c'       => '//',
    '.coffee'  => '#!/usr/bin/env coffee',
    '.exp'     => '#!/usr/bin/env expect',
    '.go'      => '#!/usr/bin/env go',
    '.js'      => '#!/usr/bin/env node',
    '.py'      => '#!/usr/bin/env python',
    '.rb'      => '#!/usr/bin/env ruby',
    '.sh'      => '#!/bin/bash'
  }

  def set_default_ext(*files, extname: DEFAULT_EXT)
    files.flatten!
    files.collect! do |file|
      if File.extname(file) == ""
        file += extname
      end
      file
    end

    if files.count <= 1
      return files[0]
    else
      return files
    end
  end

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

    Dir[File.join(dirname, '**', '*')].each do |file|
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

  def move_to_desktop(*files)
    files.flatten!
    files.each do |file|
      if File.exist?(file)
        FileUtils.cp(file, DESKTOP)
      else
        puts "No such file: '#{File.basename(file)}'"
      end
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
    puts "Reading #{File.join(dir, '**', '*')}"
    files = Dir[File.join(dir, '**', '*')]
    files.delete_if { |path| File.directory?(path) }
    files.map! { |path| [File.basename(path), path] }
    files = Hash[files]
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
      target_path = File.dirname(pathname).gsub(/^#{source}/, target)
      find_or_create_directory(target_path)
      FileUtils.cp(pathname, target_path)
    end
  end

  def find_or_create_directory(pathname)
    FileUtils.mkdir_p(pathname)
  end

  def split_path(path)
    Pathname(path).each_filename.to_a
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

  def commit_changes(dir)
    puts 'Enter a commit message:'
    commit_msg = gets.strip
    commit_msg = "commit changes #{Time.now.strftime('%Y%m%d%H%M%S')}" if commit_msg == ""
    puts ''
    puts "Committing changes for #{dir}..."
    Dir.chdir(dir)
    system('git checkout annex')
    system('git add -A')
    system('git commit -m "' + commit_msg + '"')
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

  def get_shebang(ext)
    shebang = SHEBANGS[ext]
    shebang
  end
end
