#!/usr/bin/env ruby -w
# template.rb
# Author: Andy Bettisworth
# Description: Manage local templates

require_relative 'project'

module Project
  # manage all local templates
  class Template
    TEMPLATE = File.join(HOME, 'GitHub', 'template')

    def list(template_regexp=false)
      templates = get_templates
      puts templates.inspect
      # templates = filter_templates(templates, template_regexp) if template_regexp
      # templates = templates.sort_by { |k,v| k[:filename] }
      # print_canvas_list(templates)
      templates
    end

    def fetch(*templates)
      @template_list = templates.flatten

      ask_for_template while @template_list.empty?

      @template_list.each_with_index do |target_template, index|
        @template_list[index] = default_extension(target_template)

        if File.exist?("#{TEMPLATE_PATH}/#{@template_list[index]}")
          get_template(@template_list[index])
        else
          puts "TemplateNotExistError: #{TEMPLATE_PATH}/#{@template_list[index]}"
        end
      end
    end

    def clean
      all_templates = []

      Dir.foreach("#{TEMPLATE_PATH}") do |template|
        next if File.directory?(template)
        next unless template.include?(".rb")
        all_templates << template
      end

      Dir.foreach("#{DESKTOP}") do |open_template|
        next if File.directory?(open_template)
        next unless open_template.include?(".rb")
        system("mv #{DESKTOP}/#{open_template.to_s} #{TEMPLATE_PATH}") if all_templates.include?(open_template)
      end

      sync_template
    end

    private

    def get_templates
      template_list = []

      Dir.foreach(TEMPLATE) do |file|
        next if file == '.' or file == '..'
        template_list << file
      end

      template_list
    end

    def get_template(template)
      FileUtils.cp(File.join(TEMPLATE, template), DESKTOP)
    end

    def ask_for_template
      puts "What template do you want?"
      @template_list < gets
    end

    def default_extension(template)
      if File.extname(template) == ""
        template += '.rb'
      end
      template
    end

    def template_exist?(template)
      if File.exist?("#{TEMPLATE_PATH}/#{template}")
        true
      else
        puts "WARNING: No such template exists: '#{template}'"
        false
      end
    end

    def sync_template
      system <<-CMD
        echo '';
        echo 'Commit changes in ~/.sync/.template';
        cd #{TEMPLATE_PATH};
        git checkout annex;
        git add -A;
        git commit -m "template_clean-#{Time.now.strftime('%Y%m%d%H%M%S')}";
      CMD
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

    opts.on('-c', '--clean', 'Move template(s) off Desktop and commit changes') do
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
