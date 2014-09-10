#!/usr/bin/env ruby -w
# script.rb
# Author: Andy Bettisworth
# Description: Get scripts from ~/.sync/.script

require 'optparse'

class Script
  DESKTOP = "#{ENV['HOME']}/Desktop"
  SCRIPT  = "#{ENV['HOME']}/.sync/.script"

  attr_accessor :scripts

  def fetch_all(*scripts)
    @scripts = scripts.flatten
    ask_for_script while @scripts.empty?

    @scripts.each_with_index do |s, i|
      target = default_extension(s)

      unless File.exist?("#{SCRIPT}/#{target}")
        puts "Warning: script not found! '#{target}'"
        next
      end

      get_script(target)
    end
  end

  def clean
    all_scripts = []

    Dir.foreach("#{SCRIPT}") do |script|
      next if File.directory?(script)
      next unless script.include?(".rb")
      all_scripts << script
    end

    Dir.foreach("#{DESKTOP}") do |open_script|
      next if File.directory?(open_script)
      next unless open_script.include?(".rb")
      system("mv #{DESKTOP}/#{open_script.to_s} #{SCRIPT}") if all_scripts.include?(open_script)
    end

    sync_script
  end

  private

  def get_script(target)
    system("cp #{SCRIPT}/#{target} #{DESKTOP}")
  end

  def ask_for_script
    puts "What script do you want? (ex: annex.rb, polygot.py, install_vmware.exp)"
    scripts = gets.split(/\s.*?/).flatten
    scripts.each { |s| @scripts << s }
  end

  def default_extension(script)
    script += '.rb' if File.extname(script) == ""
    script
  end

  def script_exist?(script)
    if File.exist?("#{SCRIPT}/#{script}")
      true
    else
      puts "Warning: no script found '#{script}'"
      false
    end
  end

  def sync_script
    system <<-CMD
      echo '';
      echo 'Commit changes in ~/.sync/.script';
      cd #{SCRIPT};
      git checkout annex;
      git add -A;
      git commit -m "script_clean-#{Time.now.strftime('%Y%m%d%H%M%S')}";
    CMD
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = "USAGE: script [options] [SCRIPT]"

  opts.on('-f', '--fetch', 'Copy script(s) to Desktop') do
    options[:fetch] = true
  end

  opts.on('--clean', 'Move script(s) back into  ~/.sync') do
    options[:clean] = true
  end
end
option_parser.parse!

## USAGE
script_dispatcher = Script.new
if options[:clean]
  script_dispatcher.clean
elsif options[:fetch]
  script_dispatcher.fetch_all(ARGV)
else
  puts option_parser
end
