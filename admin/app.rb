#!/usr/bin/env ruby
# app.rb
# Author: Andy Bettisworth
# Created At: 2015 0103 163526
# Modified At: 2015 0103 163526
# Description: CLI-Application for App Management

require 'optparse'

class Application
  def list(script_regexp=false)
    apps = get_all_apps
    puts apps.inspect
    # scripts = filter_scripts(scripts, script_regexp)
    # scripts = scripts.sort_by { |k,v| k[:filename]}
    # print_script_list(scripts)
    # scripts
  end

  private

  def get_all_apps
    github = get_github_apps
    gitlab = get_gitlab_apps
    github + gitlab
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: app [options] [APPLICATION]"

    opts.on('-l [REGXP]', '--list [REGXP]', 'List all matching applications') do |regexp|
      options[:list] = true
      options[:list_pattern] = regexp
    end
  end
  option_parser.parse!

  mgr = Application.new

  if options[:list]
    mgr.list(options[:list_pattern])
  # elsif options[:add]
  #   mgr.add(options[:add])
  # elsif options[:fetch]
  #   mgr.fetch(ARGV)
  # elsif options[:clean]
  #   mgr.clean
  # elsif options[:info]
  #   mgr.info(options[:info])
  # elsif options[:refresh]
  #   mgr.refresh_aliases
  # elsif options[:history]
  #   mgr.history
  else
    puts option_parser
  end
end