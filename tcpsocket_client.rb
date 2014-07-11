#!/usr/bin/ruby -w
# tcpsocket_client.rb
# Author: Andy Bettisworth
# Description: Make a request on a local TCP Server

require 'socket'

s = TCPSocket.new 'localhost', 2000

while line = s.gets # Read lines from socket
  puts line         # and print them
end

s.close             # close socket when done
