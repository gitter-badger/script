#!/usr/bin/ruby
# task.rb
# Author: Andy Bettisworth
# Description: Exec tasks

TASK_DIR = "/home/raist/.sync/.script/.tasks"

cron_locked = File.exist?("#{TASK_DIR}/cron.lock")

## Rotate background every 20 minutes
unless cron_locked
  if Time.now.strftime('%M').to_i % 20 == 0
    require "#{TASK_DIR}/rotate_background_task.rb"
    b = DesktopBackground.new
    b.images = "/home/raist/Pictures/Backgrounds"
    b.rotate
  end
end

## Purge packages that are blacklisted
unless cron_locked
  `sudo bash #{TASK_DIR}/purge_packages.sh`
end
