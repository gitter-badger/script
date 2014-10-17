#!/usr/bin/ruby -w
# feature.rb
# Author: Andy Bettisworth
# Description: A feature management

require 'optparse'
require 'yaml'

class FeatureManager
  PROJECT_PATH = "#{ENV['HOME']}/.sync/.project"

  attr_accessor :project
  attr_accessor :project_path

  def initialize
    @project = File.basename(Dir.getwd).downcase.gsub(' ', '_')
    @project_path = "#{PROJECT_PATH}/#{@project}"
  end

  def add_feature
    raise "No known project #{@project}" unless project_exist?(@project)
    feature = build_feature
    file = File.open("#{@project_path}/features.yaml", 'a+') << feature.to_yaml.gsub("---\n", '')
    file.close
    todo_commit("Added feature to project '#{@project}' #{Time.now.strftime('%Y%m%d%H%M%S')}")
  end

  def list
    raise "No known project #{@project}" unless project_exist?(@project)
    list = get_features
    list.each_with_index do |feature, index|
      puts "[#{feature[:id]}] Feature: #{feature[:name]}"
      puts "    #{feature[:individual]}"
      puts "    #{feature[:requirement]}"
      puts "    #{feature[:value]}"
      puts ""
    end
  end

  private

  def build_feature
    id = get_next_id

    puts "Feature: ____"
    name = gets until name
    puts "As a ____"
    individual = gets until individual
    puts "I want ____"
    requirement = gets until requirement
    puts "So that ____"
    value = gets until value

    feature = [{
      id: id,
      name: name,
      individual: "As a #{individual}",
      requirement: "I want #{requirement}",
      value: "So that #{value}",
      created_at: Time.now,
    }]
    feature
  end

  def get_features
    list = YAML.load_file("#{@project_path}/features.yaml")
    list
  end

  def project_exist?(project)
    File.exist?("#{PROJECT_PATH}/#{project}")
  end

  def largest_task_id(list)
    last_task = list.max_by{|h| h[:id]}
    last_task[:id]
  end

  def get_next_id
    if File.exist?("#{PROJECT_PATH}/#{@project}/features.yaml")
      list = get_all_tasks
      return largest_task_id(list) + 1
    else
      return 0
    end
  end

  def todo_commit(msg)
    `cd #{PROJECT_PATH}; git checkout -q annex; git add -A; git commit -m "#{msg}";`
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = 'USAGE: feature [options]'

  opts.on('-a', '--add', 'Add a feature') do
    options[:add] = true
  end

  opts.on('-l', '--list', 'List project features') do
    options[:list] = true
  end
end
option_parser.parse!

mgmt = FeatureManager.new

if options[:add]
  mgmt.add_feature
  exit
elsif options[:list]
  mgmt.list
  exit
end

puts option_parser