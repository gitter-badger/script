#!/usr/bin/ruby -w
# ipgeocoder.rb
# Author: Andy Bettisworth
# Description: Geocode IP Address into latitude and longitude

require 'geocoder'

class IPGeocoder
  def ping
    current_locale = Geocoder.coordinates(system('curl --silent ifconfig.me'))
    current_locale
  end
end

if __FILE__ == $0
  location = IPGeocoder.new
  puts location.ping.inspect
end
