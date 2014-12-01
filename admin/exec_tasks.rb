#!/usr/bin/ruby -w
# exec_tasks.rb
# Author: Andy Bettisworth
# Description: Execute the ~/.sync/.tasks

class Tasks
  TASKS_PATH = "#{ENV['HOME']}/.sync/.task"

  def exec
    Dir.foreach(TASKS_PATH) do |task|
      next if File.directory?(task)
      next if task == "exec_tasks.rb"
      eval(File.new("#{TASKS_PATH}/#{task}").read)
    end
  end
end

if __FILE__ == $0
  tasker = Tasks.new
  tasker.exec
end
