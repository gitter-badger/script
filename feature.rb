#!/usr/bin/ruby -w
# feature.rb
# Author: Andy Bettisworth
# Description: A feature management

require 'optparse'
require 'yaml'
require_relative 'get_naics'

## > Add naics_code

class FeatureManager
  PROJECT_PATH = "#{ENV['HOME']}/.sync/.project"
  APP_CLASS = {
    1 => 'communication',
    2 => 'entertainment',
    3 => 'environment',
    4 => 'health',
    5 => 'search',
    6 => 'navigation',
    7 => 'security',
    8 => 'trade',
    9 => 'project'
  }

  attr_accessor :project
  attr_accessor :project_path

  def initialize
    @project = File.basename(Dir.getwd).downcase.gsub(' ', '_')
    @project_path = "#{PROJECT_PATH}/#{@project}"
  end

  def add
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
    naics_getter = GetNAICSCode.new
    naics_code   = naics_getter.ask
    app_class    = get_app_class

    feature = [{
      id: id,
      name: name,
      individual: "As a #{individual}",
      requirement: "I want #{requirement}",
      value: "So that #{value}",
      app_class: app_class,
      naics_code: naics_code,
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

  def get_app_class
    APP_CLASS.each { |k,v| puts "[#{k}] #{v}" }
    puts "Which application classification does this feature best match?"
    classification = 0
    classification = gets.to_i until classification != 0
    classification
  end

  def get_naics_code
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
  mgmt.add
  exit
elsif options[:list]
  mgmt.list
  exit
end

puts option_parser
