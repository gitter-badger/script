#!/bin/bash
# cron_trigger.sh
# Author: Andy Bettisworth
# Description: trigger ruby tasks from cron

. /home/wurde/.bashrc
`ruby /home/wurde/.sync/.script/.tasks/task.rb`
