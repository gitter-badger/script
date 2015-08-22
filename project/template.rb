#!/usr/bin/env ruby -w
# template.rb
# Author: Andy Bettisworth
# Description: Manage local templates

require_relative 'project'

module Project
  TEMPLATE = File.join(HOME, 'GitHub', 'templates')

  # manage all local templates
  class Template
    def list(template_regexp = false)
      templates = get_templates
      templates = filter_templates(templates, template_regexp) if template_regexp
      templates.each { |t| puts "#{t}\n" }
      templates
    end

    def fetch(*templates)
      puts templates.inspect
      puts templates.class
      # templates = ask_for_template while templates.flatten.empty?
      # puts templates
      # raise "MissingTemplateError: No template '#{template}'" unless templates.include?(template)
      # FileUtils.cp(File.join(TEMPLATE, template), DESKTOP)
    end

    def clean
      all_templates = []

      Dir.foreach(TEMPLATE) do |template|
        next if File.directory?(template)
        next unless template.include?(".rb")
        all_templates << template
      end

      Dir.foreach(DESKTOP) do |open_template|
        next if File.directory?(open_template)
        next unless open_template.include?(".rb")
        FileUtils.mv(File.join(DESKTOP, open_template.to_s), TEMPLATE) if all_templates.include?(open_template)
      end

      sync_template
    end

    private

    def get_templates
      templates = Dir.glob(File.join(TEMPLATE, '*'))
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
      FileUtils.cp(File.join(TEMPLATE, template), DESKTOP)
    end

    def ask_for_template
      puts "What template do you want?"
      templates = gets.split(/\s.*?/).flatten
      templates
    end

    def default_extension(template)
      if File.extname(template) == ""
        template += '.rb'
      end
      template
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
