#!/usr/bin/env ruby -w
# babelfish.rb
# Author: Andy Bettisworth
# Description: detect and translate foreign languages passively

require 'termit'

`which mpg1234`
raise 'Dependency missing: apt-get mpg123' unless $? == 0

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'comm/comm'

module Comm
  class BabelFish
    include Admin

    def run
      loop do
        babbling = gets "Say>"
        puts babbling
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Comm

  babelfish = BabelFish.new
  babelfish.run

  exit 1
end
