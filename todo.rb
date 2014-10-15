#!/usr/bin/ruby -w
# todo.rb
# Author: Andy Bettisworth
# Description: A project To-Do command-line application

require 'optparse'
require 'yaml'

class TaskManager
  TODO_PATH = "#{ENV['HOME']}/.sync/.todo"

  attr_accessor :project
  attr_accessor :project_path

  def initialize
    @project = File.basename(Dir.getwd).downcase.gsub(' ', '_')
    @project_path = "#{TODO_PATH}/#{@project}"
  end

  def add_task(description)
    raise "No known project #{@project}" unless project_exist?(@project)
    id = get_next_id
    task = [{
      id: id,
      description: description,
      created_at: Time.now,
      completed_at: nil
    }]
    file = File.open("#{@project_path}/tasks.yaml", 'a+') << task.to_yaml.gsub("---\n", '')
    file.close
    todo_commit("Added task to project '#{@project}' #{Time.now.strftime('%Y%m%d%H%M%S')}")
  end

  def list
    raise "No known project #{@project}" unless project_exist?(@project)
    list = get_active_tasks
    list.each_with_index do |todo, index|
      puts "[#{todo[:id]}] #{todo[:description]}"
    end
  end

  def history
    raise "No known project #{@project}" unless project_exist?(@project)
    list = get_all_tasks
    list.each_with_index do |todo, index|
      task = "[#{todo[:id]}] #{todo[:description]} "
      task += "[COMPLETED #{todo[:completed_at]}]" if todo[:completed_at]
      puts task
    end
  end

  def complete_task(id)
    raise "No known project #{@project}" unless project_exist?(@project)
    list = get_all_tasks
    raise "No such task #{id}" unless largest_task_id(list) <= id.to_i
    list.each {|t| t[:completed_at] = Time.now if t[:id] == id.to_i }
    File.open("#{@project_path}/tasks.yaml", 'w') { |f| YAML.dump(list, f) }
    todo_commit("Completed task from project '#{@project}' #{Time.now.strftime('%Y%m%d%H%M%S')}")
  end

  private

  def project_exist?(project)
    File.exist?("#{TODO_PATH}/#{project}")
  end

  def get_active_tasks
    list = YAML.load_file("#{@project_path}/tasks.yaml")
    list.select! { |k| !k[:completed_at] }
    list
  end

  def get_all_tasks
    list = YAML.load_file("#{@project_path}/tasks.yaml")
    list
  end

  def todo_commit(msg)
    `cd #{TODO_PATH}; git checkout -q annex; git add -A; git commit -m "#{msg}";`
  end

  def largest_task_id(list)
    last_task = list.max_by{|h| h[:id]}
    last_task[:id]
  end

  def get_next_id
    if File.exist?("#{TODO_PATH}/#{@project}/tasks.yaml")
      list = get_all_tasks
      return largest_task_id(list) + 1
    else
      return 0
    end
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = 'USAGE: todo [options]'

  opts.on('-a TASK', '--add TASK', 'Add a task') do |task|
    options[:add] = task
  end

  opts.on('-l', '--list', 'List active tasks') do
    options[:list] = true
  end

  opts.on('--history', 'Show task history including active tasks') do
    options[:history] = true
  end

  opts.on('-c ID', '--complete ID', 'Complete a task') do |id|
    options[:complete] = id
  end
end
option_parser.parse!

mgmt = TaskManager.new

if options[:add]
  mgmt.add_task(options[:add])
  exit
elsif options[:list]
  mgmt.list
  exit
elsif options[:history]
  mgmt.history
  exit
elsif options[:complete]
  mgmt.complete_task(options[:complete])
  exit
end

puts option_parser