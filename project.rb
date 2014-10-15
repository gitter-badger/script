#!/usr/bin/env ruby -w
# project.rb
# Author: Andy Bettisworth
# Description: Manage projects

require 'optparse'

class ProjectManager
  TODO_PATH = "#{ENV['HOME']}/.sync/.todo"

  attr_accessor :project
  attr_accessor :project_path

  def initialize
    @project = File.basename(Dir.getwd).downcase.gsub(' ', '_')
    @project_path = "#{TODO_PATH}/#{@project}"
  end

  def init
    Dir.mkdir("#{TODO_PATH}/#{@project}") unless project_exist?(@project)
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
  end

  def list
    projects = get_projects
    projects.each do |project|
      info = YAML.load_file("#{TODO_PATH}/#{project}/project.yaml")
      puts "#{project} - #{info[:description]}"
    end
  end

  def fetch(project)
    raise "No known project #{project}" unless project_exist?(project)
    info = YAML.load_file("#{TODO_PATH}/#{project}/project.yaml")
    `mv #{info[:location]}/#{project} #{ENV['HOME']}/Desktop`
  end

  def clean(project)
    all_projects = get_projects
    desktop_dir = get_desktop_dir
    all_projects.each do |project|
      if desktop_dir.include? project
        info = YAML.load_file("#{TODO_PATH}/#{project}/project.yaml")
        `mv #{ENV['HOME']}/Desktop/#{project} #{info[:location]}`
      end
    end
  end

  def set_location(path)
  end

  def info
    raise "No known project #{@project}" unless project_exist?(@project)
    info = YAML.load_file("#{@project_path}/project.yaml")
    puts "Project:     #{@project}"
    puts "Description: #{info[:description]}"
    puts "Location:    #{info[:location]}"
    puts "Created At:  #{info[:created_at]}"
  end

  private

  def project_exist?(project)
    File.exist?("#{TODO_PATH}/#{project}")
  end

  def get_projects
    projects = Dir.entries(TODO_PATH).select! do |e|
      File.directory?(File.join(TODO_PATH, e)) and !(e == '.' || e == '..' || e == ".git")
    end
    projects
  end

  def get_desktop_dir
    desktop_dir = Dir.entries("#{ENV['HOME']}/Desktop").select! do |e|
      File.directory?(File.join("#{ENV['HOME']}/Desktop", e)) and !(e == '.' || e == '..' || e == ".git")
    end
    desktop_dir
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = 'USAGE: project [options]'

  opts.on('--init', 'Create a new project for current working directory') do
    options[:init] = true
  end

  opts.on('-l', '--list', 'List all projects') do
    options[:list] = true
  end

  opts.on('-f PROJECT', '--fetch PROJECT', 'Fetch target project') do |project|
    options[:fetch] = project
  end

  opts.on('--clean [PROJECT]', 'Clean all open projects') do |project|
    options[:clean] = project
  end

  opts.on('--set-location PATH', 'Set project target location') do |location|
    options[:set_location] = location
  end

  opts.on('--info', 'Info for current project') do
    options[:info] = true
  end
end

mgmt = ProjectManager.new

if options[:init]
  mgmt.init
  exit
if options[:list]
  mgmt.list
  exit
elsif options[:fetch]
  mgmt.fetch(options[:fetch])
  exit
elsif options[:clean]
  mgmt.clean(options[:clean])
  exit
elsif options[:set_location]
  mgmt.set_location(options[:set_location])
  exit
elsif options[:info]
  mgmt.info
  exit
end

puts option_parser
