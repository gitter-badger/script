#!/usr/bin/env ruby -w
# template.rb
# Author: Andy Bettisworth
# Detemplateion: Get templates from ~/.sync/.template

require 'optparse'

class Template
  HOME          = ENV['HOME']
  DESKTOP       = "#{HOME}/Desktop"
  TEMPLATE_PATH = "#{HOME}/.sync/.template"

  attr_accessor :template_list

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

  def get_template(target_template)
    system("cp #{TEMPLATE_PATH}/#{target_template} #{DESKTOP}")
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

options = {}
option_parser = OptionParser.new do |opts|
  opts.banner = "USAGE: template [options] [template]"

  opts.on('-f', '--fetch', 'Copy template(s) to Desktop') do
    options[:fetch] = true
  end

  opts.on('-c', '--clean', 'Move template(s) back into  ~/.sync') do
    options[:clean] = true
  end
end
option_parser.parse!

## USAGE
template_dispatcher = template.new
if options[:clean]
  template_dispatcher.clean
elsif options[:fetch]
  template_dispatcher.fetch(ARGV)
else
  puts option_parser
end
