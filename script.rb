#!/usr/bin/env ruby -w
# script.rb
# Author: Andy Bettisworth
# Description: Script Management Class

require 'optparse'

class Script
  DESKTOP       = "#{ENV['HOME']}/Desktop"
  SCRIPT        = "#{ENV['HOME']}/.sync/.script"
  BASH_ALIASES  = "#{ENV['HOME']}/.bash_aliases"
  SCRIPT_REGEXP = /\/.*\/(?<filename>.*?)$/

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

      fetch(target)
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

  def list(regexp)
    pattern = Regexp.new(regexp) if regexp
    script_dict = get_scripts(pattern)
    script_dict.each do |name, desc|
      puts "#{name  }         #{desc}"
    end
    script_dict
  end

  def refresh_aliases
    bash_aliases = File.open(BASH_ALIASES, 'w+')
    bash_aliases.puts '## CREATE aliases for ~/.sync/.script/* via ~/.bash_aliases'

    ruby_scripts = Dir["#{ENV['HOME']}/.sync/.script/*.rb"]
    ruby_scripts.each do |script|
      next if script.include?("_spec.rb")
      name = File.basename(script, '.rb')
      str_a1 = "alias #{name}="
      str_a2 = "'ruby "
      str_a3 = "#{script}'"
      str_alias = str_a1 + str_a2 + str_a3
      bash_aliases.puts str_alias
    end
    bash_aliases.close

    system "sudo chmod 755 #{BASH_ALIASES}"
    system "sudo chown #{ENV['USER']}:#{ENV['USER']} #{BASH_ALIASES}"
    system "source #{BASH_ALIASES}"
  end

  private

  def create_script(script)
    script = default_extension(script)

    puts 'Describe this script: '
    description = gets
    description ||= '...'
    File.new("#{DESKTOP}/#{script}", 'w+') <<  BOILERPLATE.gsub('$1', script).gsub('$2', description)
  end

  def get_scripts(pattern)
    script_dict = {}
    script_list = []
    File.open(BASH_ALIASES).readlines.each_with_index do |line, index|
      next if index == 0
      found_script = SCRIPT_REGEXP.match(line)

      if found_script
        script_list << found_script[:filename]
      end
    end
    script_list.select! { |s| pattern.match(s) } if pattern
    script_list.each do |s|
      d = File.open(File.join(SCRIPT, s)).readlines.select! { |l| /description:/i.match(l) }
      begin
        script_dict[s] = d[0].gsub(/# description: /i, '')
      rescue
        script_dict[s] = ''
      end
    end
    script_dict
  end

  def fetch(target)
    system("cp #{SCRIPT}/#{target} #{DESKTOP}")
  end

  def ask_for_script
    puts "What script do you want? (ex: annex.rb, polygot.py, passwd.sh, install_vmware.exp)"
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
    puts 'Enter a commit message:'
    commit_msg = gets.strip
    commit_msg = "script clean #{Time.now.strftime('%Y%m%d%H%M%S')}" if commit_msg == ""
    system <<-CMD
      echo '';
      echo 'Commit changes in ~/.sync/.script';
      cd #{SCRIPT};
      git checkout annex;
      git add -A;
      git commit -m "#{commit_msg}";
    CMD
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "USAGE: script [options] [SCRIPT]"

    opts.on('-n SCRIPT', '--new SCRIPT', 'Create a script') do |s|
      options[:add] = s
    end

    opts.on('-f', '--fetch', 'Copy script(s) to Desktop') do
      options[:fetch] = true
    end

    opts.on('--clean', 'Move script(s) off Desktop') do
      options[:clean] = true
    end

    opts.on('-l [REGXP]', '--list [REGXP]', 'List all matching scripts') do |regexp|
      options[:list] = true
      options[:list_pattern] = regexp
    end

    opts.on('--refresh', 'Refresh script Bash aliases') do
      options[:refresh] = true
    end
  end
  option_parser.parse!

  s = Script.new
  if options[:clean]
    s.clean
  elsif options[:fetch]
    s.fetch_all(ARGV)
  elsif options[:add]
    s.add(options[:add])
  elsif options[:list]
    s.list(options[:list_pattern])
  elsif options[:refresh]
    s.refresh_aliases
  else
    puts option_parser
  end
end
