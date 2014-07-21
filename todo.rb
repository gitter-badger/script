#!/usr/bin/ruby -w
# todo.rb
# Author: Andy Bettisworth
# Description: A project To-Do command-line application

require 'optparse'
require 'yaml'

class TODO
  HOME      = ENV['HOME']
  SYNC_TODO = "#{HOME}/.sync/.todo"

  def initialize
    get_project
    get_project_path
    ensure_project_exist
  end

  def list
    read_tasks
  end

  def add(description, priority, created_at=Time.now)
    add_task(description, priority, created_at)
  end

  def complete(id)
    task_list = YAML.load_file @project_path

    task_list.collect! do |task|
      if task[:id] == id
        task[:is_complete] = true
        task[:completed_at] = Time.now
      end
      task
    end

    File.open(@project_path, 'w') { |f| YAML.dump(task_list, f) }
  end

  private

  def get_project
    @project = File.basename(File.expand_path('.')).downcase.gsub(' ', '_')
  end

  def get_project
    @project_path = "#{SYNC_TODO}/#{@project}.yaml"
  end

  def ensure_project_exist
    unless File.exist?(@project_path)
      Dir.chdir SYNC_TODO
      until project_exist?
        File.new("#{@project}.yaml", 'w') << "---\n"
      end
    end
  end

  def project_exist?
    File.exist?(@project_path)
  end

  def read_tasks
    task_list = YAML.load_file(@project_path)
    task_list.select! { |k| !k[:is_complete] }
    unless task_list.nil?
      task_list.sort_by! { |k| -k[:priority] }
      task_list.each_with_index do |todo, index|
        puts "#{todo[:priority]} - [#{todo[:id]}] #{todo[:description]}"
      end
    end
  end

  def add_task(description, priority, created_at)
    task = [{
      id: rand(1000..9999),
      description: description,
      created_at: created_at,
      priority: priority,
      is_complete: false,
      completed_at: nil
    }]
    File.open(@project_path, 'a+') << task.to_yaml.gsub("---\n", '')
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = 'USAGE: todo [options]'

  opts.on('-l', '--list') do
    options[:list] = true
  end

  opts.on('-a TASK', '--add TASK') do |t|
    options[:task] = t
  end

  opts.on('-p PRIORITY', '--priority PRIORITY') do |p|
    options[:priority] = p.to_i
  end

  opts.on('-c ID', '--complete ID') do |i|
    options[:complete] = i.to_i
  end
end
option_parser.parse!

tasker = TODO.new
tasker.list if options[:list]
if options[:task]
  prio = options[:priority]
  prio ||= 0
  tasker.add(options[:task], prio)
end
task_id = options[:complete]
tasker.complete(task_id) if task_id
puts option_parser if options.empty?
