#!/usr/bin/ruby -w
# task.rb
# Author: Andy Bettisworth
# Description: Exec tasks

TASK_DIR = "#{ENV['HOME']}/.sync/.script/.tasks"

# Skip tasks if a cron.lock file is found in TASK_DIR
cron_locked = File.exist?("#{TASK_DIR}/cron.lock")

# Rotate background every 20 minutes
unless cron_locked
  require "#{TASK}/rotate_background_task.rb"
  minute = Time.now.strftime('%M')
  Background.rotate if minute.to_i % 20 == 0
end
