#!/usr/bin/ruby -w
# todo.rb
# Author: Andy Bettisworth
# Description: A project To-Do command-line application

require 'optparse'
require 'yaml'

class TODO
  HOME      = ENV['HOME']
  SYNC_TODO = "#{HOME}/.sync/.todo"

  def list
    get_project
    ensure_project_exist
    read_tasks
  end

  def add(description, priority=0, created_at=Time.now)
    get_project
    ensure_project_exist
    add_task(description, priority, created_at)
  end

  private

  def get_project
    @project = File.basename(File.expand_path('.')).downcase.gsub(' ', '_')
  end

  def project_exist?
    File.exist?("#{SYNC_TODO}/#{@project}.yaml")
  end

  def ensure_project_exist
    unless File.exist?("#{SYNC_TODO}/#{@project}.yaml")
      Dir.chdir SYNC_TODO
      until project_exist?
        File.new("#{@project}.yaml", 'w') << "---\n"
      end
    end
  end

  def read_tasks
    task_list = YAML.load_file("#{SYNC_TODO}/#{@project}.yaml")
    unless task_list.nil?
      task_list.sort_by! { |k| k[:priority] }
      task_list.each_with_index do |todo, index|
        # > add todo[:id] - to allow to enable `todo -c :id`
        puts "[#{index + 1}] #{todo[:description]}"
      end
    end
  end

  def add_task(description, priority, created_at)
    task = [{description: description, created_at: created_at, priority: priority}]
    File.open("#{SYNC_TODO}/#{@project}.yaml", 'a+') << task.to_yaml.gsub("---\n", '')
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = 'USAGE: todo [options]'

  opts.on('-l', '--list') do
    options[:list] = true
  end

  opts.on('-a TASK', '--add TASK') do |task|
    options[:task] = task
  end
end
option_parser.parse!

tasker = TODO.new
tasker.list if options[:list]
tasker.add(options[:task]) if options[:task]
# puts option_parser if options.empty?
