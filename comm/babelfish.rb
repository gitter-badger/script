#!/usr/bin/env ruby -w
# babelfish.rb
# Author: Andy Bettisworth
# Description: detect and translate foreign languages passively

require 'whatlanguage'
require 'i18n'
require 'globalize'
require 'hstore_translate'
require 'http_accept_language'
require 'easy_translate'
require 'to_lang'

require_relative 'comm'

module Comm
  class BabelFish
  end
end

if __FILE__ == $PROGRAM_NAME
  include Comm
  exit 1
end
