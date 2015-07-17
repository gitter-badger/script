#!/usr/bin/env ruby
# websocket_connection.rb
# Author: Andy Bettisworth
# Created At: 2015 0528 202532
# Modified At: 2015 0528 202532
# Description: attempt a websocket server connection

require_relative 'comm'

## WebSocket Notes

# WebSocket messages are wrapped in frames, which are a sequence of bytes.

## Receive Notes

# If length_indicator is smaller or equal to 125
#   that is the content length.
# If length_indicator is equal to 126
#   the next two bytes need to be parsed into a 16-bit unsigned integer.
# If the length_indicator is equal to 127
#   the next eight bytes will need to be parsed into a 64-bit unsigned integer
# The mask-key itself (what we use to decode the content)
#   will be the next 4 bytes.

## Send Notes

# If the size is smaller or equal to 125
#   we concatenate this to the byte array.
# If smaller than 216 (which is the maximum size of two bytes)

module Comm
  class WebSocketConnection
    attr_reader :socket

    def initialize(socket)
      @socket = socket
    end

    def recv
      fin_and_opcode            = socket.read(1).bytes
      mask_and_length_indicator = socket.read(1).bytes[0]
      length_indicator          = mask_and_length_indicator - 128

      length =  if length_indicator <= 125
                  length_indicator
                elsif length_indicator == 126
                  socket.read(2).unpack("n")[0]
                else
                  socket.read(8).unpack("Q>")[0]
                end

      keys    = socket.read(4).bytes
      encoded = socket.read(length).bytes

      decoded = encoded.each_with_index.map do |byte, index|
        byte ^ keys[index % 4]
      end

      decoded.pack("c*")
    end

    def send(message)
      bytes = [129]
      size  = message.bytesize

      bytes +=  if size <= 125
                  [size]
                elsif size < 2**16
                  [126] + [size].pack("n").bytes
                else
                  [127] + [size].pack("Q>").bytes
                end

      bytes += message.bytes
      data   = bytes.pack("C*")

      socket << data
    end
  end
end
