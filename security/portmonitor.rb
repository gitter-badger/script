#!/usr/bin/env ruby
# portmonitor.rb
# Author: Andy Bettisworth
# Created At: 2015 0719 111249
# Modified At: 2015 0719 111249
# Description: monitor traffic over a port or port range

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'security/security'

module Security
  class PortMonitor
    include Admin
  end
end
