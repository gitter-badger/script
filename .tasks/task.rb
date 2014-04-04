#!/usr/bin/ruby -w
# task.rb
# Author: Andy Bettisworth
# Description: Schedule tasks [~/.sync/.script/.tasks/*_task.rb]

require_relative "../schedule.rb"

## OPTIONS
# method:
# args:
# queue:
# delay:
# interval:
# repeat:
# task:

tactical = Schedule.new
tactical.task(task: "background_task.rb", interval: 20.minutes)
