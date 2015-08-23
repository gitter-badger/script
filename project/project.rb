#!/usr/bin/env ruby -w
# project.rb
# Author: Andy Bettisworth
# Description: Manage local projects

require 'yaml'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Project
  # manage all local projects
  class ProjectManager
    include Admin

    PROJECT_DIR = File.join(HOME, 'Projects')

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
      FileUtils.cp_r(File.join(PROJECT_DIR, project), DESKTOP)
    end

    def clean
      open_projects = get_open_projects

      if open_projects
        if open_projects.is_a? Array
          open_projects.each do |p|
            FileUtils.rm_rf(p)
            FileUtils.mv(File.join(DESKTOP, File.basename(p)), p)
          end
        else
          FileUtils.rm_rf(open_projects)
          FileUtils.mv(File.join(DESKTOP, File.basename(open_projects)), open_projects)
        end
      end
    end

    private

    def get_open_projects
      open_projects = []
      all_projects  = []

      Dir.glob(File.join(PROJECT_DIR, '*')).each do |entry|
        all_projects << File.basename(entry)
      end

      Dir.glob(File.join(DESKTOP, '*')) do |entry|
        next if entry == '.' or entry == '..'

        filename = File.basename(entry)

        if all_projects.include?(filename)
          puts "  Cleaning project '#{filename}'..."
          open_projects << File.join(PROJECT_DIR, filename)
        else
          next
        end
      end

      open_projects
    end

    def ensure_project_dir
      FileUtils.mkdir_p PROJECT_DIR unless File.exist? PROJECT_DIR
    end

    def get_projects
      projects = Dir.glob(File.join(PROJECT_DIR, '*'))
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
        if File.exist?(File.join(PROJECT_DIR, project, 'info.yml'))
          info = {}
          info[:info] = YAML.load_file(File.join(PROJECT_DIR, project, 'info.yml'))
          info[:project] = project
          info
        else
          project
        end
      end
      projects
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

    opts.on('-f', '--fetch PROJECT', 'Copy matching project(s) to Desktop') do |project|
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
