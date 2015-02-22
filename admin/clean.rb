#!/usr/bin/env ruby
# clean.rb
# Author: Andy Bettisworth
# Created At: 2015 0222 021800
# Modified At: 2015 0222 021800
# Description: cleanup the desktop of canvases, scripts, and applications

class CleanDesktop
  HOME     = ENV['HOME']
  DESKTOP  = "#{HOME}/Desktop"
  CANVAS   = "#{HOME}/GitHub/canvas"
  SCRIPT   = "#{HOME}/GitHub/script"
  GITHUB_LOCAL  = "#{HOME}/GitHub"
  GITLAB_LOCAL  = "#{HOME}/GitLab"

  def clean
    clean_app
    clean_canvas
    clean_script
  end

  private

  def clean_app
    open_apps = get_open_apps

    if open_apps
      if open_apps.is_a? Array
        open_apps.each do |app|
          system <<-CMD
            rm --recursive --force #{app};
            mv #{ENV['HOME']}/Desktop/#{File.basename(app)} #{app};
          CMD
        end
      else
        system <<-CMD
          rm --recursive --force #{open_apps};
          mv #{ENV['HOME']}/Desktop/#{File.basename(open_apps)} #{open_apps};
        CMD
      end
    end
  end

  def get_open_apps
    open_apps = []

    github_apps = get_github_apps
    gitlab_apps = get_gitlab_apps

    Dir.glob("#{ENV['HOME']}/Desktop/*/") do |entry|
      next if entry == '.' or entry == '..'

      filename = File.basename(entry)
      is_github = true if github_apps.include?(filename)
      is_gitlab = true if gitlab_apps.include?(filename)

      if is_github and is_gitlab
        next
      elsif is_github
        puts "  Cleaning GitHub application '#{filename}'..."
        open_apps << "#{GITHUB_LOCAL}/#{filename}"
      elsif is_gitlab
        puts "  Cleaning GitLab application '#{filename}'..."
        open_apps << "#{GITLAB_LOCAL}/#{filename}"
      else
        next
      end
    end

    open_apps
  end

  def get_github_apps
    entries = []
    Dir.glob("#{GITHUB_LOCAL}/*/").each do |entry|
      entries << File.basename(entry)
    end
    entries
  end

  def get_gitlab_apps
    entries = []
    Dir.glob("#{GITLAB_LOCAL}/*/").each do |entry|
      entries << File.basename(entry)
    end
    entries
  end

  def clean_canvas
    lang_dir = get_lang_dir
    canvases = get_canvases(lang_dir)

    canvases_out = get_open_canvases(canvases)
    canvases_out = get_canvas_location(canvases_out)

    if canvases_out
      if canvases_out.is_a? Array
        canvases_out.each { |s| system("mv #{DESKTOP}/#{File.basename(s)} #{s}") }
      else
        system("mv #{DESKTOP}/#{File.basename(canvases_out)} #{canvases_out}")
      end

      commit_changes
    end
  end

  def get_lang_dir(lang_regexp=false)
    language = []

    Dir.foreach(CANVAS) do |entry|
      next unless File.directory?(File.join(CANVAS, entry))
      next if entry == '.' or entry == '..' or entry == '.git'
      language << entry
    end

    language
  end

  def get_canvases(lang_dir)
    canvas_list = []

    lang_dir.each do |lang|
      target_lang = lang
      Dir.foreach("#{CANVAS}/#{target_lang}") do |file|
        next if file == '.' or file == '..'
        canvas = {}
        canvas = get_canvas_info("#{CANVAS}/#{target_lang}/#{file}")
        canvas_list << canvas
      end
    end

    canvas_list
  end

  def get_open_canvases(canvases)
    open_canvases = []

    Dir.foreach("#{DESKTOP}") do |entry|
      next if File.directory?(entry)
      open_canvases << entry if canvas_exist?(entry)
    end

    open_canvases
  end

  def get_canvas_location(*canvases)
    lang_dir    = get_lang_dir
    canvas_list = get_canvases(lang_dir)

    canvases.flatten!
    canvases.collect! do |canvas|
      canvas = set_default_ext(canvas)
      canvas = set_default_prefix(canvas)
      cl = canvas_list.select { |c| c[:filename] == canvas }

      if cl.count >= 1
        "#{CANVAS}/#{cl[0][:language]}/#{canvas}"
      else
        canvas
      end
    end

    if canvases.count <= 1
      return canvases[0]
    else
      return canvases
    end
  end

  def set_default_ext(*canvases)
    canvases.flatten!
    canvases.collect! do |canvas|
      if File.extname(canvas) == ""
        canvas += '.rb'
      end
      canvas
    end

    if canvases.count <= 1
      return canvases[0]
    else
      return canvases
    end
  end

  def set_default_prefix(*canvases)
    canvases.flatten!
    canvases.collect! do |canvas|
      unless /canvas_/.match(canvas)
        canvas = 'canvas_' + canvas
      end
      canvas
    end

    if canvases.count <= 1
      return canvases[0]
    else
      return canvases
    end
  end

  def commit_changes
    puts 'Enter a commit message:'
    commit_msg = gets.strip
    commit_msg = "canvas clean #{Time.now.strftime('%Y%m%d%H%M%S')}" if commit_msg == ""
    system <<-CMD
      echo '';
      echo 'Commit changes in ~/.sync/.canvas';
      cd #{CANVAS};
      git checkout annex;
      git add -A;
      git commit -m "#{commit_msg}";
    CMD
  end

  def clean_script
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

  def get_app_categories
    categories = []

    Dir.foreach(SCRIPT) do |entry|
      next unless File.directory?(File.join(SCRIPT, entry))
      next if entry == '.' or entry == '..' or entry == '.git'
      categories << entry
    end

    categories
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
end

mgmt = CleanDesktop.new
mgmt.clean
