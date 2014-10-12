#!/usr/bin/ruby -w
# todo.rb
# Author: Andy Bettisworth
# Description: A project To-Do command-line application

require 'optparse'
require 'yaml'

class ProjectManager
  TODO_PATH = "#{ENV['HOME']}/.sync/.todo"

  def init_project
    project = File.basename(Dir.getwd).downcase.gsub(' ', '_')
    Dir.mkdir("#{TODO_PATH}/#{project}") unless project_exist?(project)
  end

  def add_task(task)
    puts task
    puts task.class
  end

  private

  def project_exist?(project)
    File.exist?("#{TODO_PATH}/#{project}")
  end

  # def read_tasks
  #   task_list = YAML.load_file(@project_path)
  #   task_list.select! { |k| !k[:is_complete] }
  #   unless task_list.nil?
  #     task_list.sort_by! { |k| -k[:priority] }
  #     task_list.each_with_index do |todo, index|
  #       puts "#{todo[:priority]} - [#{todo[:id]}] #{todo[:description]}"
  #     end
  #   end
  # end

  # def add_task(description, priority, created_at)
  #   task = [{
  #     id: rand(1000..9999),
  #     description: description,
  #     created_at: created_at,
  #     priority: priority,
  #     is_complete: false,
  #     completed_at: nil
  #   }]
  #   File.open(@project_path, 'a+') << task.to_yaml.gsub("---\n", '')
  # end
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
end
option_parser.parse!

mgmt = ProjectManager.new

if options[:init]
  mgmt.init_project
  exit
elsif options[:add]
  mgmt.add_task(options[:add])
  exit
end

puts option_parser
