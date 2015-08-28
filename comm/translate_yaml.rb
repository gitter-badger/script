#!/usr/bin/env ruby
# translate_yaml.rb
# Author: Andy Bettisworth
# Created At: 2015 0827 111902
# Modified At: 2015 0827 111902
# Description: convert yaml strings using google translate api

require 'termit'

require 'admin/admin'
require 'comm/comm'

module Comm
  class TranslateYaml
    include Admin

    def translate
    end
  end
end

if $0 == $PROGRAM_NAME
  include Comm

  translator = TranslateYaml.new

  if ARGV.size = 3
    translator.translate(ARGV[0], ARGV[1], ARGV[2])
    exit 0
  else
    puts "Usage: translate_YAML en es myfile.yaml"
    exit 1
  end
end
