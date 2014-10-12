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
  end

  def add_task(description)
    raise "No known project #{@project}" unless project_exist?(@project)
    task = [{
      description: description,
      created_at: Time.now,
      completed_at: nil
    }]
    File.open("#{@project_path}/tasks.yaml", 'a+') << task.to_yaml.gsub("---\n", '')
  end

  def list_tasks
    raise "No known project #{@project}" unless project_exist?(@project)
    task_list = YAML.load_file("#{@project_path}/tasks.yaml")
    task_list.select! { |k| !k[:completed_at] }
    task_list.each_with_index do |todo, index|
      puts "[#{index + 1}] #{todo[:description]}"
    end
  end

  def complete_task(id)
    raise "No known project #{@project}" unless project_exist?(@project)
    task_list = YAML.load_file("#{@project_path}/tasks.yaml")
    raise "No such task #{id}" unless (1..task_list.count).member?(id.to_i)
    puts task_list[id.to_i - 1]
    # task_list[id.to_i - 1][:completed_at] = Time.now
    # File.open("#{@project_path}/tasks.yaml", 'w') { |f| YAML.dump(task_list, f) }
  end

  private

  def project_exist?(project)
    File.exist?("#{TODO_PATH}/#{project}")
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

  opts.on('-c ID', '--complete ID', 'Complete a task') do |id|
    options[:complete] = id
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
elsif options[:complete]
  mgmt.complete_task(options[:complete])
  exit
end

puts option_parser