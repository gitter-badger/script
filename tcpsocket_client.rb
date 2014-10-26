#!/usr/bin/ruby -w
# tcpsocket_client.rb
# Author: Andy Bettisworth
# Description: Make a request on a local TCP Server

require 'socket'

if __FILE__ == $0
  s = TCPSocket.new 'localhost', 34891

  while line = s.gets # Read lines from socket
    puts line # and print them
  end

  s.close # close socket when done
end
