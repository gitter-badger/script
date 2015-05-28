#!/usr/bin/env ruby -w
# script.rb
# Author: Andy Bettisworth
# Created At: 2014 1005 193820
# Modified At: 2014 1105 193823
# Description: Script for CLI Application management

require 'optparse'

module Admin
  class Script
    HOME     = ENV['HOME']
    SCRIPT   = "#{HOME}/GitHub/script"
    BINARIES = {
      '.rb'  => 'ruby',
      '.py'  => 'python',
      '.exp' => 'expect',
      '.sh'  => 'bash'
    }
    DEPENDENCIES = {
      '.rb' => Regexp.new(/require.*?\s\'(?<dependency>.*)\'/i),
      '.py' => Regexp.new(/import.*?\s(?<dependency>.*)/i)
    }
    CATEGORIES = ['admin','comm','environ','fun','health','nav','project','search','security','trade']
    SCRIPT_REGEXP = /^alias\s(?<alias>.*?)=\'(?<binary>.*?)\s(?<pathname>.*)\/(?<filename>.*?)'$/
    BOILERPLATE = <<-TXT
  $0
  # $1
  # Author: Andy Bettisworth
  # Created At: $2
  # Modified At: $3
  # Description: $4
    TXT

    def list(script_regexp=false)
      categories = get_app_categories
      scripts = get_scripts(categories)
      scripts = filter_scripts(scripts, script_regexp)
      scripts = scripts.sort_by { |k,v| k[:filename]}
      print_script_list(scripts)
      scripts
    end

    def add(script)
      raise 'ScriptExistsError: A script by that name already exists.' if script_exist?(script)
      create_script(script)
    end

    def fetch(*scripts)
      scripts = ask_for_script while scripts.flatten.empty?
      scripts = set_default_ext(scripts)
      scripts = get_script_location(scripts)
      move_script_to_desktop(scripts)
    end

    def info(script)
      script = set_default_ext(script)

      if script_exist?(script)
        script = get_script_location(script)
        script = get_script_info(script)
        print_script_info(script)
      else
        STDERR.puts "NoSuchScriptError: Did not find script '#{script}'"
        exit 1
      end
    end

    def clean
      categories  = get_app_categories
      scripts     = get_scripts(categories)

      scripts_out = get_open_scripts(scripts)
      scripts_out = get_script_location(scripts_out)

      if scripts_out
        if scripts_out.is_a? Array
          scripts_out.each { |s| system("mv #{HOME}/Desktop/#{File.basename(s)} #{s}") }
        else
          system("mv -f #{HOME}/Desktop/#{File.basename(scripts_out)} #{scripts_out}")
        end

        commit_changes
      end
    end

    def refresh_aliases
      new_bash_aliases = File.open("#{HOME}/.bash_aliases", 'w+')

      categories = get_app_categories
      scripts = get_scripts(categories)
      scripts = scripts.sort_by { |k,v| k[:filename]}
      scripts.each do |script|
        extension   = File.extname(script[:filename])
        name        = File.basename(script[:filename], extension)
        alias_cmd   = "alias #{name}="
        exec_binary = "'#{BINARIES[extension]} "
        script_path = "#{SCRIPT}/#{script[:category]}/#{script[:filename]}'"
        str_alias   = alias_cmd + exec_binary + script_path
        new_bash_aliases.puts str_alias
      end
      new_bash_aliases.close

      system "source #{"#{HOME}/.bash_aliases"}"
    end

    def history
      files = `cd #{SCRIPT}; git diff --name-status "@{7 days ago}" "@{0 days ago}"`
      files = files.split("\n")
      puts "7-Day Script Activity:"

      scripts = {}
      files.each do |f|
        filename = f[1..-1].strip
        scripts[filename] = f[0]
      end

      added_scripts    = scripts.select { |s,a| a == "A"}
      modified_scripts = scripts.select { |s,a| a == "M"}
      deleted_scripts  = scripts.select { |s,a| a == "D"}
      puts ""
      puts "#{added_scripts.count} script(s) added: "
      added_scripts.each { |s,a| puts "  #{s}" }
      puts ""
      puts "#{modified_scripts.count} script(s) modified: "
      modified_scripts.each { |s,a| puts "  #{s}" }
      puts ""
      puts "#{deleted_scripts.count} script(s) deleted: "
      deleted_scripts.each { |s,a| puts "  #{s}" }
    end

    private

    def create_script(script)
      puts 'Which application category does this script belong to?'
      puts CATEGORIES.join(', ')
      category = ''
      until CATEGORIES.include?(category) do
        category = gets.strip
        break if CATEGORIES.include?(category)
        puts "Error: '#{category}' is not one of the available categories."
      end

      puts 'Describe this script: '
      description = gets
      description ||= '...'

      script = set_default_ext(script)
      header = BOILERPLATE.gsub!('$0', get_shebang(File.extname(script)))
      header = header.gsub!('$1', script)
      header = header.gsub!('$2', Time.now.strftime('%Y %m%d %H%M%S'))
      header = header.gsub!('$3', Time.now.strftime('%Y %m%d %H%M%S'))
      header = header.gsub!('$4', description)

      File.new("#{SCRIPT}/#{category}/#{script}", 'w+') << header
      File.new("#{HOME}/Desktop/#{script}", 'w+') << header
    end

    def set_default_ext(*scripts)
      scripts.flatten!
      scripts.collect! do |script|
        if File.extname(script) == ""
          script += '.rb'
        end
        script
      end

      if scripts.count <= 1
        return scripts[0]
      else
        return scripts
      end
    end

    def filter_nonexistent(*scripts)
      targets = scripts.flatten
      targets.select! { |s| script_exist?(s) }
      raise "No matching scripts for #{scripts.inspect}" if targets.count < 1
      targets
    end

    def ask_for_script
      puts "What script do you want? (ex: annex.rb, polygot.py, passwd.sh, install_vmware.exp)"
      scripts = gets.split(/\s.*?/).flatten
      scripts
    end

    def script_exist?(script)
      script = set_default_ext(script)

      categories = get_app_categories
      scripts = get_scripts(categories)
      scripts.select! { |s| s[:filename] == script }

      if scripts.count >= 1
        true
      else
        false
      end
    end

    def get_script_info(filepath)
      script = {}

      dirname  = File.dirname(filepath)
      top_path = File.expand_path('..', dirname)
      category = dirname.gsub("#{top_path}/", '')

      file_head = File.open(filepath).readlines
      s = file_head[0..11].join('')

      if s.valid_encoding?
        script[:category] = category
        script[:shebang] = file_head[0].strip
        script[:filename] = File.basename(filepath)

        author = /author:(?<author>.*)/i.match(s.force_encoding('UTF-8'))
        script[:author] = author[:author].strip if author

        created_at = /created at:(?<created_at>.*)/i.match(s.force_encoding('UTF-8'))
        script[:created_at] = created_at[:created_at].strip if created_at

        modified_at = /modified at:(?<modified_at>.*)/i.match(s.force_encoding('UTF-8'))
        script[:modified_at] = modified_at[:modified_at].strip if modified_at

        description = /description:(?<description>.*)/i.match(s.force_encoding('UTF-8'))
        script[:description] = description[:description].strip if description

        dep_regexp = DEPENDENCIES[File.extname(filepath)]
        dependencies = s.scan(dep_regexp) if dep_regexp
        script[:dependencies] = dependencies.flatten if dependencies
      else
        STDERR.puts "ERROR: Not valid UTF-8 encoding in '#{File.basename(filepath)}'"
        exit 1
      end

      script
    end

    def filter_scripts(scripts, script_regexp=false)
      pattern = Regexp.new(script_regexp) if script_regexp
      scripts.select! { |s| pattern.match(s[:filename]) } if pattern
      scripts
    end

    def print_script_info(script)
      puts "filename:     #{script[:filename]}"
      puts "author:       #{script[:author]}"
      puts "created_at:   #{script[:created_at]}"
      puts "modified_at:  #{script[:modified_at]}"
      puts "description:  #{script[:description]}"
      puts "dependencies: #{script[:dependencies]}"
    end

    def print_script_list(scripts)
      scripts.each do |script|
        space = 31 - script[:filename].length if script[:filename].length < 31
        space ||= 1
        puts "#{script[:filename]} #{' ' * space} (#{script[:category]}) #{script[:description]}"
      end
    end

    def get_description(script)
      scripts = get_sync_scripts
      scripts.select! { |s| /#{script}/i.match(s[:filename])}
      unless scripts.empty?
        return scripts[0][:description]
      else
        return '...script does not exist (script --refresh) at your convenience'
      end
    end

    def get_shebang(ext)
      shebang = "#!/usr/bin/env #{BINARIES[ext]}"
      shebang
    end

    def get_script_location(*scripts)
      categories   = get_app_categories
      scripts_list = get_scripts(categories)

      scripts.flatten!
      scripts.collect! do |script|
        sl = scripts_list.select { |s| s[:filename] == script }

        if sl.count >= 1
          "#{SCRIPT}/#{sl[0][:category]}/#{script}"
        else
          script
        end
      end

      if scripts.count <= 1
        return scripts[0]
      else
        return scripts
      end
    end

    def move_script_to_desktop(*scripts)
      scripts.flatten!
      scripts.each do |script|
        if File.exist?(script)
          system("cp #{script} #{HOME}/Desktop")
        else
          msg = "Warning: script not found '#{script}'!\n"
          extname = File.extname(script)
          matches = get_scripts_matches(File.basename(script, extname))
          matches = matches.collect! { |s| s[:filename] }
          if matches.count > 0
            msg += "Possible matches include: \n\t"
            msg += matches.join("\n\t")
          end
          puts msg
        end
      end
    end

    def get_scripts_matches(script)
      categories   = get_app_categories
      scripts_list = get_scripts(categories)
      scripts_list.select! { |s| /#{script}/.match(s[:filename]) }
      scripts_list
    end

    def get_scripts(categories)
      script_list = []

      categories.each do |category|
        target_category = category
        Dir.foreach("#{SCRIPT}/#{target_category}") do |file|
          next if file == '.' or file == '..'
          script = {}
          script = get_script_info("#{SCRIPT}/#{target_category}/#{file}")
          script_list << script
        end
      end

      script_list
    end

    def get_open_scripts(scripts)
      open_scripts = []

      Dir.foreach("#{HOME}/Desktop") do |entry|
        next if File.directory?(entry)
        open_scripts << entry if script_exist?(entry)
      end

      open_scripts
    end

    def get_app_categories
      categories = []

      Dir.foreach(SCRIPT) do |entry|
        next unless File.directory?(File.join(SCRIPT, entry))
        next if entry == '.' or entry == '..' or entry == '.git'
        categories << entry
      end

      categories
    end

    def get_sync_scripts
      script_list = []

      Dir.foreach(SCRIPT) do |file|
        next if File.directory?(File.join(SCRIPT, file))
        script = {}

        file_head = File.open(File.join(SCRIPT, file)).readlines
        s = file_head[0..11].join('')

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

      File.open("#{HOME}/.bash_aliases").readlines.each_with_index do |line, index|
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

    def commit_changes
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

    def branch_exist?(repository, branch)
      Dir.chdir repository
      branches = `git branch`
      return branches.include?(branch)
    end

    def remote_exist?(repository, branch)
      Dir.chdir repository
      remotes = `git remote -v`
      return remotes.include?(branch)
    end
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: script [options] SCRIPT"

    opts.on('-l [REGXP]', '--list [REGXP]', 'List all matching scripts') do |regexp|
      options[:list] = true
      options[:list_pattern] = regexp
    end

    opts.on('-n SCRIPT', '--new SCRIPT', 'Create a new script') do |name|
      options[:add] = name
    end

    opts.on('-f', '--fetch', 'Copy script(s) to the Desktop') do
      options[:fetch] = true
    end

    opts.on('--clean', 'Move script(s) off Desktop and commit changes') do
      options[:clean] = true
    end

    opts.on('--info SCRIPT', 'Show script header information') do |script|
      options[:info] = script
    end

    opts.on('--refresh', 'Refresh the list of ~/bash_aliases') do
      options[:refresh] = true
    end

    opts.on('--history', 'List recent script activity') do
      options[:history] = true
    end
  end
  option_parser.parse!

  script = Admin::Script.new

  if options[:list]
    script.list(options[:list_pattern])
  elsif options[:add]
    script.add(options[:add])
  elsif options[:fetch]
    script.fetch(ARGV)
  elsif options[:clean]
    script.clean
  elsif options[:info]
    script.info(options[:info])
  elsif options[:refresh]
    script.refresh_aliases
  elsif options[:history]
    script.history
  else
    puts option_parser
  end
end