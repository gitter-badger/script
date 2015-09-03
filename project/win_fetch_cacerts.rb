#!/usr/bin/env ruby
# win_fetch_cacerts.rb
# Author: Andy Bettisworth
# Created At: 2015 0902 203343
# Modified At: 2015 0902 203343
# Description: fetch certificate to solve windows ssl ruby error

require 'net/http'

RUBY_VER = 'Ruby21'

cacert_file = File.join('C:', RUBY_VER, 'cacert.pem')

Net::HTTP.start("curl.haxx.se") do |http|
  resp = http.get("/ca/cacert.pem")
  if resp.code == "200"
    open(cacert_file, "wb") { |file| file.write(resp.body) }
    puts "\n\nA bundle of certificate authorities has been installed to"
    puts "C:\\#{RUBY_VER}\\cacert.pem\n"
    puts "* Please set SSL_CERT_FILE in your current command prompt session with:"
    puts "     set SSL_CERT_FILE=C:\\#{RUBY_VER}\\cacert.pem"
    puts "* To make this a permanent setting, add it to Environment Variables"
    puts "  under Control Panel -> Advanced -> Environment Variables"
  else
    abort "\n\n>>>> A cacert.pem bundle could not be downloaded."
  end
end
