#!/usr/bin/env ruby -w
# script.rb
# Author: Andy Bettisworth
# Description: Script Management Class

require 'optparse'

class Script
  DESKTOP = "#{ENV['HOME']}/Desktop"
  SCRIPT  = "#{ENV['HOME']}/.sync/.script"

  attr_accessor :script_list

  BOILERPLATE = <<-TXT
#!/usr/bin/env ruby -w
# $1
# Author: Andy Bettisworth
# Description: $2
  TXT

  def add(script)
    raise 'ScriptExistsError: A script by that name already exists.' if script_exist?(script)
    create_script(script)
  end

  def fetch_all(*scripts)
    @script_list = scripts.flatten
    ask_for_script while @script_list.empty?

    @script_list.each_with_index do |s, i|
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
      all_scripts << script
    end

    Dir.foreach("#{DESKTOP}") do |open_script|
      next if File.directory?(open_script)
      system("mv #{DESKTOP}/#{open_script} #{SCRIPT}") if all_scripts.include?(open_script)
    end

    sync_script
  end

  private

  def create_script(script)
    script = default_extension(script)

    puts 'Describe this script: '
    description = gets
    description ||= '...'
    File.new("#{DESKTOP}/#{script}", 'w+') <<  BOILERPLATE.gsub('$1', script).gsub('$2', description)
  end

  def get_script(target)
    system("cp #{SCRIPT}/#{target} #{DESKTOP}")
  end

  def ask_for_script
    puts "What script do you want? (ex: annex.rb, polygot.py, install_vmware.exp)"
    scripts = gets.split(/\s.*?/).flatten
    scripts.each { |s| @script_list << s }
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

  opts.on('-n SCRIPT', '--new SCRIPT', 'Create a script') do |s|
    options[:add] = s
  end

  opts.on('-f', '--fetch', 'Copy script(s) to Desktop') do
    options[:fetch] = true
  end

  opts.on('--clean', 'Move script(s) back into  ~/.sync') do
    options[:clean] = true
  end
end
option_parser.parse!

## USAGE
s = Script.new
if options[:clean]
  s.clean
elsif options[:fetch]
  s.fetch_all(ARGV)
elsif options[:add]
  s.add(options[:add])
else
  puts option_parser
end
