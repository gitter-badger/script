#!/usr/bin/ruby -w
# exec_tasks.rb
# Author: Andy Bettisworth
# Description: Execute the ~/.sync/tasks

class Tasks
  HOME       = ENV['HOME']
  TASKS_PATH = "#{HOME}/.sync/.task"

  def every_minute
    Dir.foreach(TASKS_PATH) do |task|
      next if File.directory?(task)
      next if task == "exec_tasks.rb"
      eval(File.new("#{TASKS_PATH}/#{task}").read)
    end
  end
end

if __FILE__ == $0
  tasker = Tasks.new
  tasker.every_minute
end
