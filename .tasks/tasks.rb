#!/usr/bin/ruby -w
# task.rb
# Author: Andy Bettisworth
# Description: Exec tasks

TASK_DIR = "#{ENV['HOME']}/.sync/.script/.tasks"

# Skip tasks if a cron.lock file is found in TASK_DIR
cron_locked = File.exist?("#{TASK_DIR}/cron.lock")

# Rotate background every 20 minutes
unless cron_locked
  require "#{TASK_DIR}/rotate_background_task.rb"

  if Time.now.strftime('%M').to_i % 20 == 0
    background = DesktopBackground.new
    background.image_directory = "#{ENV['HOME']}/Pictures/Backgrounds"
    background.rotate
  end
end
