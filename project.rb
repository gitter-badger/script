#!/usr/bin/env ruby -w
# project.rb
# Author: Andy Bettisworth
# Description: Manage projects

require 'optparse'
require 'yaml'

class ProjectManager
  PROJECT = "#{ENV['HOME']}/.sync/.project"

  attr_accessor :project
  attr_accessor :project_path

  def initialize
    @project = File.basename(Dir.getwd).downcase.gsub(' ', '_')
    @project_path = "#{PROJECT}/#{@project}"
  end

  def init
    unless project_exist?(@project)
      Dir.mkdir("#{PROJECT}/#{@project}")
      puts "Describe this project:\n"
      description = gets.strip until description
      project = {
        description: description,
        location: File.dirname(Dir.pwd),
        created_at: Time.now
      }
      file = File.open("#{@project_path}/project.yaml", 'a+') << project.to_yaml.gsub("---\n", '')
      file.close
      todo_commit("Created project '#{@project}' #{Time.now.strftime('%Y%m%d%H%M%S')}")
    else
      puts "Project already exists for #{@project}"
    end
  end

  def list(regexp)
    pattern = Regexp.new(regexp) if regexp
    projects = get_projects
    projects.select! { |s| pattern.match(s) } if pattern
    projects.each do |project|
      info = YAML.load_file("#{PROJECT}/#{project}/project.yaml")
      puts "#{project} - #{info[:description]}"
    end
  end

  def fetch(project)
    raise "No known project #{project}" unless project_exist?(project)
    info = YAML.load_file("#{PROJECT}/#{project}/project.yaml")
    `mv #{info[:location]}/#{project} #{ENV['HOME']}/Desktop`
  end

  def clean
    all_projects = get_projects
    desktop_dir = get_desktop_dir
    all_projects.each do |project|
      if desktop_dir.include? project
        info = YAML.load_file("#{PROJECT}/#{project}/project.yaml")
        `mv #{ENV['HOME']}/Desktop/#{project} #{info[:location]}`
      end
    end
  end

  def set_location(path)
    raise "No known project #{@project}" unless project_exist?(@project)
    info = YAML.load_file("#{PROJECT}/#{@project}/project.yaml")
    old_path = info[:location]
    info[:location] = path
    File.open("#{@project_path}/project.yaml", 'w') { |f| YAML.dump(info, f) }
    todo_commit("Set project location to '#{path}'")
    `mv #{old_path}/#{@project} #{path}`
  end

  def info(project)
    project = @project if project == '.'
    raise "No known project #{project}" unless File.exist?("#{PROJECT}/#{project}")
    info = YAML.load_file("#{PROJECT}/#{project}/project.yaml")
    puts "Project:     #{project}"
    puts "Description: #{info[:description]}"
    puts "Location:    #{info[:location]}"
    puts "Created At:  #{info[:created_at]}"
  end

  private

  def project_exist?(project)
    File.exist?("#{PROJECT}/#{project}")
  end

  def get_projects
    projects = Dir.entries(PROJECT).select! do |e|
      File.directory?(File.join(PROJECT, e)) and !(e == '.' || e == '..' || e == ".git")
    end
    projects
  end

  def get_desktop_dir
    desktop_dir = Dir.entries("#{ENV['HOME']}/Desktop").select! do |e|
      File.directory?(File.join("#{ENV['HOME']}/Desktop", e)) and !(e == '.' || e == '..' || e == ".git")
    end
    desktop_dir
  end

  def todo_commit(msg)
    `cd #{PROJECT}; git checkout -q annex; git add -A; git commit -m "#{msg}";`
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: project [options]'

    opts.on('--init', 'Create a new project for current working directory') do
      options[:init] = true
    end

    opts.on('-l [REGXP]', '--list [REGXP]', 'List all matching projects') do |regexp|
      options[:list] = true
      options[:list_pattern] = regexp
    end

    opts.on('-f PROJECT', '--fetch PROJECT', 'Fetch target project') do |project|
      options[:fetch] = project
    end

    opts.on('--clean', 'Move project(s) off Desktop') do
      options[:clean] = true
    end

    opts.on('--set-location PATH', 'Set project target location') do |location|
      options[:set_location] = location
    end

    opts.on('-i [PROJECT]', '--info [PROJECT]', 'Info for current project') do |project|
      if project
        options[:info] = project
      else
        options[:info] = '.'
      end
    end
  end
  option_parser.parse!

  mgmt = ProjectManager.new

  if options[:init]
    mgmt.init
    exit
  elsif options[:list]
    mgmt.list(options[:list_pattern])
    exit
  elsif options[:fetch]
    mgmt.fetch(options[:fetch])
    exit
  elsif options[:clean]
    mgmt.clean
    exit
  elsif options[:set_location]
    mgmt.set_location(options[:set_location])
    exit
  elsif options[:info]
    mgmt.info(options[:info])
    exit
  end

  puts option_parser
end
