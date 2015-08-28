#!/usr/bin/env ruby
# translate_yaml.rb
# Author: Andy Bettisworth
# Created At: 2015 0827 111902
# Modified At: 2015 0827 111902
# Description: convert yaml strings using google translate api

require 'termit'
require 'yaml'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'comm/comm'

module Comm
  # translate yaml using google api
  class TranslateYaml
    include Admin

    def translate(from, to, file_path)
      file_path = File.expand_path(file_path)
      dir_path  = File.dirname(file_path)
      require_file(file_path)

      @source_lang = from
      @target_lang = to

      data = YAML.load_file(file_path)
      translation_loop(data)
      puts "#{ @translation.inspect }"

      File.open(File.join(dir_path, "#{to}.yml"), 'w+') { |f| YAML.dump(@translation, f) }
    end

    private

    def translation_loop(data, translation = {}, parent_key = [])
      @translation ||= translation

      data.each do |key, value|
        unless value.is_a? Enumerable
          # > insert values
        else
          # > nest hashes
          puts "keys: #{ value.keys.inspect }"
          @translation.merge [[key, Hash.new]].to_h
          translation_loop(value, @translation, parent_key)
        end
      end
    end
  end
end

if $0 == $PROGRAM_NAME
  include Comm

  translator = TranslateYaml.new

  if ARGV.count == 3
    translator.translate(ARGV[0], ARGV[1], ARGV[2])
    exit 0
  else
    puts "Usage: translate_yaml en es myfile.yml"
    exit 1
  end
end
