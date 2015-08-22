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

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'comm/comm'

module Comm
  class BabelFish
    include Admin
  end
end

if __FILE__ == $PROGRAM_NAME
  include Comm
  exit 1
end
