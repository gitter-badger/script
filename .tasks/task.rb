#!/usr/bin/ruby -w
# task.rb
# Author: Andy Bettisworth
# Description: Schedule tasks [~/.sync/.script/.tasks/*_task.rb]

TASK = "#{ENV['HOME']}/.sync/.script/.tasks"

## OPTIONS
# method:
# args:
# queue:
# delay:
# interval:
# repeat:
# task:

cron_locked = File.exist?("#{TASK}/cron.lock")

## Rotate background every 20 minutes
unless cron_locked
  require "#{TASK}/rotate_background_task.rb"
  minute = Time.now.strftime('%M')
  Background.rotate if minute.to_i % 20 == 0
end

## TEST
# unless cron_locked
#   suffix = Random.new.rand(1..99)
#   File.open("#{ENV['HOME']}/Desktop/file_#{suffix}.txt", 'w')
# end
