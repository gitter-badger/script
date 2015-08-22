#!/usr/bin/env ruby
# estimate.rb
# Author: Andy Bettisworth
# Created At: 2015 0719 112139
# Modified At: 2015 0719 112139
# Description: get average cost of something

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'trade/trade'

module Trade
  class Estimate
    include Admin
  end
end
