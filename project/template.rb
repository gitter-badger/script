#!/usr/bin/env ruby -w
# template.rb
# Author: Andy Bettisworth
# Description: Manage local templates

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'project/project'

module Project
  # manage all local templates
  class Template
    include Admin

    TEMPLATE_DIR = File.join(HOME, 'GitHub', 'templates')

    def list(template_regexp = false)
      templates = get_templates
      templates = filter_templates(templates, template_regexp) if template_regexp
      templates.each { |t| puts "#{t}\n" }
      templates
    end

    def fetch(*templates)
      templates = ask_for_template while templates.flatten.empty?
      templates = set_default_ext(templates)
      templates = set_template_location(templates)
      move_to_desktop(templates)
    end

    def clean
      templates = get_open_templates
      templates = set_template_location(templates)

      if templates.is_a? Array
        templates.each do |t|
          FileUtils.mv(File.join(DESKTOP, File.basename(t)), t)
        end
      else
        FileUtils.mv(File.join(DESKTOP, File.basename(templates)), templates)
      end

      commit_changes(TEMPLATE_DIR)
    end

    private

    def get_open_templates
      open_templates = []

      Dir.foreach(DESKTOP) do |entry|
        next if File.directory?(entry)
        open_templates << entry if template_exist?(entry)
      end

      open_templates
    end

    def template_exist?(template)
      templates = get_templates

      if templates.include?(template)
        true
      else
        false
      end
    end

    def get_templates
      templates = Dir.glob(File.join(TEMPLATE_DIR, '*'))
      templates = templates.reject { |d| d == '.' || d == '..' || d == ".git" }
      templates = templates.collect { |t| File.basename(t) }
      templates
    end

    def filter_templates(templates, template_regexp=false)
      pattern = Regexp.new(template_regexp) if template_regexp
      templates.select! { |a| pattern.match(a) } if pattern
      templates
    end

    def get_template(template)
      FileUtils.cp(File.join(TEMPLATE_DIR, template), DESKTOP)
    end

    def ask_for_template
      puts "What template do you want?"
      templates = gets.split(/\s.*?/).flatten
      templates
    end

    def set_template_location(*templates)
      templates.flatten!
      templates.collect! do |template|
        File.join(TEMPLATE_DIR, template)
      end
      templates
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Project
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: template [options] FILE'

    opts.on('-l', '--list [REGXP]', 'List matching templates') do |regexp|
      options[:list] = true
      options[:list_regexp] = regexp
    end

    opts.on('-f', '--fetch', 'Copy matching template(s) to Desktop') do
      options[:fetch] = true
    end

    opts.on('--clean', 'Move template(s) off Desktop and commit changes') do
      options[:clean] = true
    end
  end
  option_parser.parse!

  template = Template.new

  if options[:list]
    template.list(options[:list_regexp])
    exit 0
  elsif options[:fetch]
    template.fetch(ARGV)
    exit 0
  elsif options[:clean]
    template.clean
    exit 0
  else
    puts option_parser
    exit 1
  end
end
