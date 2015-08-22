#!/usr/bin/env ruby
# craigs.rb
# Author: Andy Bettisworth
# Created At: 2015 0719 111329
# Modified At: 2015 0719 111329
# Description: interface with Craigslist

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'trade/trade'

module Trade
  class Craigslist
    include Admin
  end
end
