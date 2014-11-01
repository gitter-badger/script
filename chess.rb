#!/usr/bin/env ruby -w
# chess.rb
# Author: Andy Bettisworth
# Description: Play a game of chess at the command-line

# > represent the board 8x8 64 square array
class ChessGame
  def play
    board = Array.new(8, Array.new(8, 1))
    board.each do |row|
      puts row.inspect
    end
  end
end

if __FILE__ == $0
  game = ChessGame.new
  game.play
end
