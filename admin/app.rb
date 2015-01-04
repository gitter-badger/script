#!/usr/bin/env ruby
# app.rb
# Author: Andy Bettisworth
# Created At: 2015 0103 163526
# Modified At: 2015 0103 163526
# Description: CLI-Application for App Management

require 'optparse'

class Application
  GITHUB_LOCAL  = "#{ENV['HOME']}/GitHub"
  GITLAB_LOCAL  = "#{ENV['HOME']}/GitLab"

  def list(app_regexp=false)
    apps = get_all_apps
    apps = filter_apps(apps, app_regexp)
    puts apps.inspect
    # scripts = scripts.sort_by { |k,v| k[:filename]}
    # print_script_list(scripts)
    # apps
  end

  private

  def filter_apps(apps, app_regexp=false)
    pattern = Regexp.new(app_regexp) if app_regexp
    apps.select! { |a| pattern.match(a[:filename]) } if pattern
    apps
  end

  def get_all_apps
    apps = get_github_apps
    apps += get_gitlab_apps
    apps
  end

  def get_github_apps
    Dir.entries(GITHUB_LOCAL).reject! {|x| x == '.' or x == '..'}
  end

  def get_gitlab_apps
    Dir.entries(GITLAB_LOCAL).reject! {|x| x == '.' or x == '..'}
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