#!/usr/bin/ruby -w
# ipgeocoder.rb
# Author: Andy Bettisworth
# Description: Geocode IP Address into latitude and longitude

require 'geocoder'

require_relative 'nav'

module Nav
  # convert IP into Lat,Lng
  class IPGeocoder
    def ping
      current_locale = Geocoder.coordinates(system('curl --silent ifconfig.me'))
      current_locale
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Nav

  location = IPGeocoder.new
  puts location.ping.inspect
end
