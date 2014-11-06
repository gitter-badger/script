#!/usr/bin/env ruby -w
# script.rb
# Author: Andy Bettisworth
# Created At: 2014 1005 193820
# Modified At: 2014 1105 193823
# Description: Script Management Class

require 'optparse'

class Script
  DESKTOP       = "#{ENV['HOME']}/Desktop"
  SCRIPT        = "#{ENV['HOME']}/.sync/.script"
  BASH_ALIASES  = "#{ENV['HOME']}/.bash_aliases"
  SCRIPT_REGEXP = /^alias\s(?<alias>.*?)=\'(?<binary>.*?)\s(?<pathname>.*)\/(?<filename>.*?)'$/
  ALIAS_CMD = {
    '.rb'  => 'ruby',
    '.py'  => 'python',
    '.exp' => 'expect',
    '.sh'  => 'bash'
  }

  attr_accessor :script_list

  BOILERPLATE = <<-TXT
#!/usr/bin/env ruby -w
# $1
# Author: Andy Bettisworth
# Created At: $2
# Modified At: $3
# Description: $4
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
        msg = "Warning: script not found '#{target}'!"
        matches = get_scripts_matches(s)
        if matches
          msg += " Possible matches " + matches.inspect.to_s
        end
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
    bash_aliases.puts '## Create aliases for ~/.sync/.script/*'

    script_list = Dir["#{ENV['HOME']}/.sync/.script/*"].delete_if { |s| File.directory?(s) }
    script_list.each do |script|
      next if /_spec/.match(script)
      extension = File.extname(script)
      name = File.basename(script, extension)
      alias_cmd = "alias #{name}="
      exec_binary = "'#{ALIAS_CMD[extension]} "
      script_path = "#{script}'"
      str_alias = alias_cmd + exec_binary + script_path
      bash_aliases.puts str_alias
    end
    bash_aliases.close

    system "source #{BASH_ALIASES}"
  end

  def history
    files = `cd #{SCRIPT}; git diff --name-status "@{7 days ago}" "@{0 days ago}"`
    files = files.split("\n")
    puts "7-Day Script Activity:"
    puts files
  end

  def info(script)
    if script_exist?(script)
      get_script_info(script)
    else
      puts "No such file exists named: '#{script}'"
    end
  end

  def create_script(script)
    script = default_extension(script)

    puts 'Describe this script: '
    description = gets
    description ||= '...'
    header = BOILERPLATE.gsub('$1', script)
    hedaer = header.gsub('$2', Time.now.strftime('%Y %m%d %H%M%S'))
    hedaer = header.gsub('$3', Time.now.strftime('%Y %m%d %H%M%S'))
    hedaer = header.gsub('$4', description)
    File.new("#{DESKTOP}/#{script}", 'w+') << header
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

  def get_scripts(pattern)
    script_dict = {}

    script_list = get_bash_aliases
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

  def get_script_info(script)
    scripts = get_sync_scripts
    scripts.select! { |s| /#{script}/i.match(s[:filename]) }
    puts scripts
  end

  def get_sync_scripts
    script_list = []

    Dir.foreach("#{SCRIPT}") do |file|
      next if File.directory?(file) || file == '.git'
      script = {}

      file_head = File.open(File.join(SCRIPT, file)).readlines
      s = file_head[0..11].join("\n")

      script[:shebang] = file_head[0].strip
      script[:filename] = file

      author = /author:(?<author>.*)/i.match(s)
      script[:author] = author[:author].strip if author

      created_at = /created at:(?<created_at>.*)/i.match(s)
      script[:created_at] = created_at[:created_at].strip if created_at

      modified_at = /modified at:(?<modified_at>.*)/i.match(s)
      script[:modified_at] = modified_at[:modified_at].strip if modified_at

      description = /description:(?<description>.*)/i.match(s)
      script[:description] = description[:description].strip if description

      dependencies = s.scan(/require.*?\s\'(?<dependency>.*)\'/i)
      script[:dependencies] = dependencies.flatten if dependencies

      script_list << script
    end

    script_list
  end

  def get_bash_aliases
    script_list = []

    File.open(BASH_ALIASES).readlines.each_with_index do |line, index|
      next if index == 0

      found_script = SCRIPT_REGEXP.match(line)
      if found_script
        script = {}

        script[:alias]    = found_script[:alias]
        script[:binary]   = found_script[:binary]
        script[:pathname] = "#{found_script[:pathname]}/#{found_script[:filename]}"
        script[:filename] = found_script[:filename]

        script_list << script
      end
    end

    script_list
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

    opts.on('--history', 'List recent script activity') do
      options[:history] = true
    end

    opts.on('--info SCRIPT', 'Show script information') do |script|
      options[:info] = script
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
  elsif options[:history]
    s.history
  elsif options[:info]
    s.info(options[:info])
  else
    puts option_parser
  end
end
