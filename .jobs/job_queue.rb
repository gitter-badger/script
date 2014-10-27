#!/usr/bin/ruby
# job_queue.rb
# Author: Andy Bettisworth
# Description: Exec jobs in queue

JOB_DIR = "#{ENV['HOME']}/.sync/.script/.jobs"

cron_locked = File.exist?("#{JOB_DIR}/cron.lock")

## Rotate background every 20 minutes
unless cron_locked
  if Time.now.strftime('%M').to_i % 20 == 0
    require "#{JOB_DIR}/rotate_background_task.rb"
    b = DesktopBackground.new
    b.images = "#{ENV['HOME']}/Pictures/Backgrounds"
    b.rotate
  end
end

## Purge packages that are blacklisted
unless cron_locked
  `sudo bash #{JOB_DIR}/purge_packages.sh`
end
