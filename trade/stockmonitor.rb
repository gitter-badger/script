#!/usr/bin/env ruby
# stockmonitor.rb
# Author: Andy Bettisworth
# Created At: 2015 0719 112218
# Modified At: 2015 0719 112218
# Description: monitor updates to stock valuation

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'trade/trade'

module Trade
  class StockMonitor
    include Admin
  end
end
