#!/usr/bin/env ruby
# websocket_connection.rb
# Author: Andy Bettisworth
# Created At: 2015 0528 202532
# Modified At: 2015 0528 202532
# Description: attempt a websocket server connection

require_relative 'comm'

module Comm
  class WebSocketConnection
    attr_reader :socket

    def initialize(socket)
      @socket = socket
    end
  end
end
