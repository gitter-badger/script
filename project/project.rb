#!/usr/bin/env ruby -w
# project.rb
# Author: Andy Bettisworth
# Description: Manage local projects

require 'fileutils'
require 'yaml'

module Project
  HOME    = ENV['HOME']
  DESKTOP = File.join(HOME, 'Desktop')
  PROJECT = File.join(HOME, 'Projects')

  class ProjectManager
    def list(project_regexp = false)
      ensure_project_dir
      projects = get_projects
      projects = filter_projects(projects, project_regexp) if project_regexp
      projects = get_info(projects)

      projects.each do |project|
        if project.is_a? Hash
          puts project[:project]
          puts "  #{project[:info]}"
        else
          puts project
        end
      end
    end

    def fetch(project)
      projects = get_projects
      raise "MissingProjectError: No project '#{project}'" unless projects.include?(project)
      FileUtils.cp_r(File.join(PROJECT, project), DESKTOP)
    end

    def clean
      open_projects = get_open_projects

      if open_projects
        if open_projects.is_a? Array
          open_projects.each do |project|
            FileUtils.rm_rf(project)
            FileUtils.mv(File.join(HOME, 'Desktop', File.basename(project)), project)
          end
        else
          FileUtils.rm_rf(open_projects)
          FileUtils.mv(File.join(HOME, 'Desktop', File.basename(open_projects)), open_projects)
        end
      end
    end

    private

    def get_open_projects
      open_projects = []
      all_projects  = []

      Dir.glob(File.join(PROJECT, '*')).each do |entry|
        all_projects << File.basename(entry)
      end

      Dir.glob(File.join(DESKTOP, '*')) do |entry|
        next if entry == '.' or entry == '..'

        filename = File.basename(entry)

        if all_projects.include?(filename)
          puts "  Cleaning project '#{filename}'..."
          open_projects << File.join(PROJECT, filename)
        else
          next
        end
      end

      open_projects
    end

    def ensure_project_dir
      FileUtils.mkdir_p PROJECT unless File.exist? PROJECT
    end

    def get_projects
      projects = Dir.glob(File.join(PROJECT, '*'))
      projects = projects.reject { |d| d == '.' || d == '..' || d == ".git" }
      projects = projects.collect { |p| File.basename(p) }
      projects
    end

    def filter_projects(projects, project_regexp=false)
      pattern = Regexp.new(project_regexp) if project_regexp
      projects.select! { |a| pattern.match(a) } if pattern
      projects
    end

    def get_info(projects)
      projects = projects.collect do |project|
        if File.exist?(File.join(PROJECT, project, 'info.yml'))
          info = {}
          info[:info] = YAML.load_file(File.join(PROJECT, project, 'info.yml'))
          info[:project] = project
          info
        else
          project
        end
      end
      projects
    end

    def get_desktop_dir
      desktop_dir = Dir.glob(File.join(DESKTOP, '*'))
      desktop_dir = desktop_dir.reject { |d| d == '.' || d == '..' || d == ".git" }
      desktop_dir = desktop_dir.collect { |p| File.basename(p) }
      desktop_dir
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Project
  require 'optparse'

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
  end
  option_parser.parse!

  mgmt = ProjectManager.new

  if options[:list]
    mgmt.list(options[:list_pattern])
    exit 0
  elsif options[:fetch]
    mgmt.fetch(options[:fetch])
    exit 0
  elsif options[:clean]
    mgmt.clean
    exit 0
  end

  puts option_parser
  exit 1
end
