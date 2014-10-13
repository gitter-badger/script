#!/usr/bin/ruby -w
# todo.rb
# Author: Andy Bettisworth
# Description: A project To-Do command-line application

require 'optparse'
require 'yaml'

class ProjectManager
  TODO_PATH = "#{ENV['HOME']}/.sync/.todo"

  attr_accessor :project
  attr_accessor :project_path

  def initialize
    @project = File.basename(Dir.getwd).downcase.gsub(' ', '_')
    @project_path = "#{TODO_PATH}/#{@project}"
  end

  def init_project
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

  def add_task(description)
    raise "No known project #{@project}" unless project_exist?(@project)
    task = [{
      description: description,
      created_at: Time.now,
      completed_at: nil
    }]
    file = File.open("#{@project_path}/tasks.yaml", 'a+') << task.to_yaml.gsub("---\n", '')
    file.close
    todo_commit("Added task to project '#{@project}' #{Time.now.strftime('%Y%m%d%H%M%S')}")
  end

  def list_tasks
    raise "No known project #{@project}" unless project_exist?(@project)
    list = get_list
    list.each_with_index do |todo, index|
      puts "[#{index + 1}] #{todo[:description]}"
    end
  end

  def list_projects
    # list = []
    puts Dir.entries(TODO_PATH) #.select
    # {|entry| File.directory? File.join(TODO_PATH, entry) and !(entry =='.' || entry == '..' || '.git') }
  end

  def complete_task(id)
    raise "No known project #{@project}" unless project_exist?(@project)
    list = get_list
    raise "No such task #{id}" unless (1..list.count).member?(id.to_i)
    list[id.to_i - 1][:completed_at] = Time.now
    file = File.open("#{@project_path}/tasks.yaml", 'w') { |f| YAML.dump(list, f) }
    file.close
    todo_commit("Completed task from project '#{@project}' #{Time.now.strftime('%Y%m%d%H%M%S')}")
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

  def get_list
    list = YAML.load_file("#{@project_path}/tasks.yaml")
    list.select! { |k| !k[:completed_at] }
    list
  end

  def todo_commit(msg)
    `cd #{TODO_PATH}; git checkout -q annex; git add -A; git commit -m "#{msg}";`
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = 'USAGE: todo [options]'

  opts.on('--init', 'Create a new project for current working directory') do
    options[:init] = true
  end

  opts.on('-a TASK', '--add TASK', 'Add a task') do |task|
    options[:add] = task
  end

  opts.on('-l', '--list', 'List all tasks') do
    options[:list] = true
  end

  opts.on('--list-projects', 'List all projects') do
    options[:list_projects] = true
  end

  opts.on('-c ID', '--complete ID', 'Complete a task') do |id|
    options[:complete] = id
  end

  opts.on('--info', 'Info for current project') do
    options[:info] = true
  end
end
option_parser.parse!

mgmt = ProjectManager.new

if options[:init]
  mgmt.init_project
  exit
elsif options[:add]
  mgmt.add_task(options[:add])
  exit
elsif options[:list]
  mgmt.list_tasks
  exit
elsif options[:list_projects]
  mgmt.list_projects
  exit
elsif options[:complete]
  mgmt.complete_task(options[:complete])
  exit
elsif options[:info]
  mgmt.info
  exit
end

puts option_parser