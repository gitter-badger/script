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
      require_file(file_path)

      yaml = YAML.load_file(file_path)
      # > build new yaml
      # > iterate over yaml
        # > transale strings
      # > dump new yaml
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
    puts "Usage: translate_yaml en es myfile.yaml"
    exit 1
  end
end
