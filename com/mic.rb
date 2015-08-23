#!/usr/bin/env ruby
# mic.rb
# Author: Andy Bettisworth
# Created At: 2015 0719 105910
# Modified At: 2015 0719 105910
# Description: start or stop external audio recording

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'comm/comm'

module Comm
  # interface with computer microphone
  class Mic
    include Admin
  end
end

if __FILE__ == $PROGRAM_NAME
  include Comm
end
