#!/usr/bin/env ruby
# job_queue.rb
# Author: Andy Bettisworth
# Description: Exec jobs in queue

SCRIPT = "#{ENV['HOME']}/.sync/.script"

cron_locked = File.exist?("#{SCRIPT}/cron.lock")

## Rotate background every 20 minutes
unless cron_locked
  if Time.now.strftime('%M').to_i % 20 == 0
    `rotate_background`
  end
end

## Purge packages that are blacklisted
unless cron_locked
  if Time.now.strftime('%M').to_i % 20 == 0
    `purge_packages`
  end
end
