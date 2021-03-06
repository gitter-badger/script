#!/usr/bin/ruby -w
# todo.rb
# Author: Andy Bettisworth
# Description: A project To-Do command-line application

require 'yaml'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'admin/wmtitle'
require 'project/project'

module Project
  class TaskManager
    include Admin
    
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

    def list
      list = get_active_tasks
      list.each_with_index do |todo, index|
        puts "[#{todo[:id]}] #{todo[:description]}"
      end
    end

    def add_task(*description)
      description = ask_for_description if description.flatten.empty?
      description = description.join(' ') if description.is_a? Array

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
      wm.set(task[0][:description])
    end

    def history
      list = get_all_tasks
      list.each_with_index do |todo, index|
        task = "[#{todo[:id]}] #{todo[:description]} "
        task += "[COMPLETED #{todo[:completed_at]}]" if todo[:completed_at]
        puts task
      end
    end

    def focus_task(id)
      list = get_all_tasks
      raise "No such task #{id}" unless id.to_i <= largest_task_id(list)
      list.select! { |t| t[:id].to_s == id }
      wm = SetWMTitle.new
      wm.set(list[0][:description])
    end

    def complete_task(id)
      list = get_all_tasks
      raise "No such task #{id}" unless id.to_i <= largest_task_id(list)
      list.each { |t| t[:completed_at] = Time.now if t[:id] == id.to_i }
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

    def ask_for_description
      puts "Describe the task:\n"
      description = gets.strip until description
      description
    end

    def get_active_tasks
      raise 'No tasks exist for this project' unless tasks_exist?
      list = YAML.load_file("#{@project_path}/tasks.yaml")
      list.select! { |k| !k[:completed_at] }
      list.sort_by! { |k| k[:id] }.reverse!
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
end

if __FILE__ == $PROGRAM_NAME
  include Project
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: todo [options]'

    opts.on('-l', '--list', 'List uncomplete tasks') do
      options[:list] = true
    end

    opts.on('-n', '--new', 'Add a new task') do
      options[:new] = true
    end

    opts.on('-f ID', '--focus ID', 'Set a specific task as current focus') do |id|
      options[:focus] = id
    end

    opts.on('-c ID', '--complete ID', 'Complete a specific task') do |id|
      options[:complete] = id
    end

    opts.on('--history', 'Show all tasks') do
      options[:history] = true
    end
  end
  option_parser.parse!

  mgmt = TaskManager.new

  if options[:list]
    mgmt.list
  elsif options[:new]
    mgmt.add_task(ARGV)
  elsif options[:focus]
    mgmt.focus_task(options[:focus])
  elsif options[:complete]
    mgmt.complete_task(options[:complete])
  elsif options[:history]
    mgmt.history
  else
    puts option_parser
    exit 1
  end
end
