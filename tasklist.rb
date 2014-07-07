#!/usr/bin/ruby -w
# tasklist.rb
# Author: Andy Bettisworth
# Description: Task list management system

project_task -l

require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = "project_task [options]"

  opts.on('-l', '--list', '')
  opts.on('-l', '--list', '')
end

## > ACTIONS
# CRUD projects
# NOTE this creates a my_project.yaml file in PROJECT_DIRECTORY

# list open, closed, or all tasks
# NOTE if no project given, use current_project

# set current project

# CRUD tasks

# complete a task

# claim a task

# project or all project sync (with github as remote repository)

## NOTE use yaml files for project task lists
