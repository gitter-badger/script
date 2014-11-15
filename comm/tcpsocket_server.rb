#!/usr/bin/ruby -w
# tcpsocket_server.rb
# Author: Andy Bettisworth
# Description: Create a TCP Server on localhost to send a hello response

require 'socket'

if __FILE__ == $0
  server = TCPServer.new 2000 # Server bound to port 2000

  loop do
    client = server.accept    # Wait for a client to connect
    client.puts "Hello !"
    client.puts "Time is #{Time.now}"
    client.close
  end
end
