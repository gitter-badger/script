#!/usr/bin/ruby -w
# todo.rb
# Author: Andy Bettisworth
# Description: A project To-Do command-line application

require 'optparse'
require 'yaml'
require_relative '../admin/wmtitle'

class TaskManager
  PROJECT = "#{ENV['HOME']}/.sync/.project"

  attr_accessor :project
  attr_accessor :project_path

  def initialize(pathname=false)
    unless pathname
      @project = File.basename(Dir.getwd).downcase.gsub(' ', '_')
      @project_path = "#{PROJECT}/#{@project}"
    else
      @project = pathname
      @project_path = "#{PROJECT}/#{@project}"
    end

    raise "No known project #{@project}" unless project_exist?
  end

  def add_task(description)
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

    wm = SetWMTitle.new
    puts task[0][:description]
    puts ""
    wm.set(task[0][:description])
  end

  def list
    list = get_active_tasks
    list.each_with_index do |todo, index|
      puts "[#{todo[:id]}] #{todo[:description]}"
    end
  end

  def history
    list = get_all_tasks
    list.each_with_index do |todo, index|
      task = "[#{todo[:id]}] #{todo[:description]} "
      task += "[COMPLETED #{todo[:completed_at]}]" if todo[:completed_at]
      puts task
    end
  end

  def complete_task(id)
    list = get_all_tasks
    raise "No such task #{id}" unless id.to_i <= largest_task_id(list)
    list.each {|t| t[:completed_at] = Time.now if t[:id] == id.to_i }
    File.open("#{@project_path}/tasks.yaml", 'w') { |f| YAML.dump(list, f) }
    todo_commit("Completed task from project '#{@project}' #{Time.now.strftime('%Y%m%d%H%M%S')}")
  end

  private

  def project_exist?
    File.exist?(@project_path)
  end

  def tasks_exist?
    File.exist?("#{@project_path}/tasks.yaml")
  end

  def get_active_tasks
    raise 'No tasks exist for this project' unless tasks_exist?
    list = YAML.load_file("#{@project_path}/tasks.yaml")
    list.select! { |k| !k[:completed_at] }
    list
  end

  def get_all_tasks
    raise 'No tasks exist for this project' unless tasks_exist?
    list = YAML.load_file("#{@project_path}/tasks.yaml")
    list
  end

  def todo_commit(msg)
    `cd #{PROJECT}; git checkout -q annex; git add -A; git commit -m "#{msg}";`
  end

  def largest_task_id(list)
    last_task = list.max_by{|h| h[:id]}
    last_task[:id]
  end

  def get_next_id
    if tasks_exist?
      list = get_all_tasks
      return largest_task_id(list) + 1
    else
      return 0
    end
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: todo [options]'

    opts.on('-a TASK', '--add TASK', 'Add a new task') do |task|
      options[:add] = task
    end

    opts.on('-l', '--list', 'List uncomplete tasks') do
      options[:list] = true
    end

    opts.on('--history', 'Show all tasks') do
      options[:history] = true
    end

    opts.on('-c ID', '--complete ID', 'Complete a specific task') do |id|
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
  else
    puts option_parser
  end
end
