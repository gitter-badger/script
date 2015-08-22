#!/usr/bin/env ruby -w
# script.rb
# Author: Andy Bettisworth
# Created At: 2014 1005 193820
# Modified At: 2014 1105 193823
# Description: Manage local scripts

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'project/project'

module Project
  # manage all local scripts
  class Script
    include Admin

    SCRIPT_DIR    = File.join(HOME, 'GitHub', 'script')
    CATEGORIES    = ['admin','comm','environ','fun','health','nav','project','search','security','trade']
    SCRIPT_REGEXP = /^alias\s(?<alias>.*?)=\'(?<binary>.*?)\s(?<pathname>.*)\/(?<filename>.*?)'$/
    BOILERPLATE   = <<-TXT
$0
# $1
# Author: Andy Bettisworth
# Created At: $2
# Modified At: $3
# Description: $4
    TXT

    def list(script_regexp = false)
      categories = get_app_categories
      scripts = get_scripts(categories)
      scripts = filter_scripts(scripts, script_regexp) if script_regexp
      scripts = scripts.sort_by { |k, v| k[:filename] }
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
      move_to_desktop(scripts)
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
          scripts_out.each { |s| FileUtils.mv(File.join(HOME, 'Desktop', File.basename(s)), s) }
        else
          FileUtils.mv(File.join(HOME, 'Desktop', File.basename(scripts_out)), scripts_out)
        end

        commit_changes
      end
    end

    def refresh_aliases
      new_bash_aliases = File.open(File.join(HOME, '.bash_aliases'), 'w+')

      categories = get_app_categories
      scripts = get_scripts(categories)
      scripts = scripts.sort_by { |k,v| k[:filename]}
      scripts.each do |script|
        extension   = File.extname(script[:filename])
        name        = File.basename(script[:filename], extension)
        alias_cmd   = "alias #{name}="
        exec_binary = "'#{BINARIES[extension]} "
        script_path = File.join(SCRIPT_DIR, script[:category], script[:filename])
        str_alias   = alias_cmd + exec_binary + script_path
        new_bash_aliases.puts str_alias
      end
      new_bash_aliases.close

      system "source #{ File.join(HOME, '.bash_aliases') }"
    end

    def history
      Dir.chdir SCRIPT_DIR
      files = `git diff --name-status "@{7 days ago}" "@{0 days ago}"`
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

      File.new(File.join(SCRIPT_DIR, category, script), 'w+') << header
      File.new(File.join(HOME, 'Desktop', script), 'w+') << header
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

      f = File.open(filepath)
      file_head = f.readlines
      s = file_head[0..11].join('')
      f.close

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
          File.join(SCRIPT_DIR, sl[0][:category], script)
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
        Dir.foreach(File.join(SCRIPT_DIR, target_category)) do |file|
          next if file == '.' or file == '..'
          script = {}
          script = get_script_info(File.join(SCRIPT_DIR, target_category, file))
          script_list << script
        end
      end

      script_list
    end

    def get_open_scripts(scripts)
      open_scripts = []

      Dir.foreach(DESKTOP) do |entry|
        next if File.directory?(entry)
        open_scripts << entry if script_exist?(entry)
      end

      open_scripts
    end

    def get_app_categories
      categories = []

      Dir.foreach(SCRIPT_DIR) do |entry|
        next unless File.directory?(File.join(SCRIPT_DIR, entry))
        next if entry == '.' or entry == '..' or entry == '.git'
        categories << entry
      end

      categories
    end

    def get_sync_scripts
      script_list = []

      Dir.foreach(SCRIPT_DIR) do |file|
        next if File.directory?(File.join(SCRIPT_DIR, file))
        script = {}

        file_head = File.open(File.join(SCRIPT_DIR, file)).readlines
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

      File.open(File.join(HOME, '.bash_aliases')).readlines.each_with_index do |line, index|
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
      puts ''
      puts 'Committing changes for scripts...'
      Dir.chdir(SCRIPT_DIR)
      system('git checkout annex')
      system('git add -A')
      system('git commit -m "' + commit_msg + '"')
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

if __FILE__ == $PROGRAM_NAME
  include Project
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: script [options] SCRIPT'

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

  script = Script.new

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
    exit 1
  end
end
