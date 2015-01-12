#!/usr/bin/env ruby -w
# project.rb
# Author: Andy Bettisworth
# Description: Manage projects

require 'optparse'
require 'fileutils'
require 'yaml'

class ProjectManager
  PROJECT  = "#{ENV['HOME']}/Projects"

  def list(regexp)
    ensure_project_dir

    projects = get_projects
    puts projects.inspect
    # pattern = Regexp.new(regexp) if regexp
    # projects.select! { |s| pattern.match(s) } if pattern

    # if projects.count > 0
    #   projects.each do |project|
    #     info = YAML.load_file("#{PROJECT}/#{project}/project.yaml")
    #     puts "#{project} - #{info[:description]}"
    #   end
    # else
    #   puts "No projects exist on this computer."
    # end
  end

  # def fetch(project)
  #   ensure_project_dir
  #   raise "No known project #{project}" unless project_exist?(project)
  #   info = YAML.load_file("#{PROJECT}/#{project}/project.yaml")
  #   `mv #{info[:location]}/#{project} #{ENV['HOME']}/Desktop`
  # end

  # def clean
  #   ensure_project_dir
  #   all_projects = get_projects
  #   desktop_dir = get_desktop_dir
  #   all_projects.each do |project|
  #     if desktop_dir.include? project
  #       info = YAML.load_file("#{PROJECT}/#{project}/project.yaml")
  #       `mv #{ENV['HOME']}/Desktop/#{project} #{info[:location]}`
  #     end
  #   end
  # end

  # def info(project)
  #   ensure_project_dir
  #   project = @project if project == '.'
  #   raise "No known project #{project}" unless File.exist?("#{PROJECT}/#{project}")
  #   info = YAML.load_file("#{PROJECT}/#{project}/project.yaml")
  #   puts "Project:     #{project}"
  #   puts "Description: #{info[:description]}"
  #   puts "Location:    #{info[:location]}"
  #   puts "Created At:  #{info[:created_at]}"
  # end

  private

  def get_projects
    projects = Dir.glob("#{PROJECT}/*/")
    projects = projects.reject { |d| d == '.' || d == '..' || d == ".git" }
    projects
  end

  # def project_exist?(project)
  #   File.exist?("#{PROJECT}/#{project}")
  # end

  # def get_desktop_dir
  #   desktop_dir = Dir.entries("#{ENV['HOME']}/Desktop").select! do |e|
  #     File.directory?(File.join("#{ENV['HOME']}/Desktop", e)) and !(e == '.' || e == '..' || e == ".git")
  #   end
  #   desktop_dir
  # end

  # def todo_commit(msg)
  #   `cd #{PROJECT}; git checkout -q annex; git add -A; git commit -m "#{msg}";`
  # end

  # def ensure_project_dir
  #   FileUtils.mkdir_p PROJECT unless File.exist? PROJECT
  # end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: project [options] PROJECT'

    opts.on('-l [REGXP]', '--list [REGXP]', 'List all matching projects') do |regexp|
      options[:list] = true
      options[:list_pattern] = regexp
    end

    opts.on('-f PROJECT', '--fetch PROJECT', 'Move projects to Desktop') do |project|
      options[:fetch] = project
    end

    opts.on('--clean', 'Move project(s) off Desktop') do
      options[:clean] = true
    end

    opts.on('-i [PROJECT]', '--info [PROJECT]', 'Info for current project') do |project|
      if project
        options[:info] = project
      else
        options[:info] = '.'
      end
    end
  end
  option_parser.parse!

  mgmt = ProjectManager.new

  if options[:list]
    mgmt.list(options[:list_pattern])
    exit
  elsif options[:fetch]
    mgmt.fetch(options[:fetch])
    exit
  elsif options[:clean]
    mgmt.clean
    exit
  elsif options[:info]
    mgmt.info(options[:info])
    exit
  end

  puts option_parser
end
