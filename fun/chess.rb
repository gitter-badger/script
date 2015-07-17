#!/usr/bin/env ruby -w
# chess.rb
# Author: Andy Bettisworth
# Description: Play a game of chess at the command-line

require_relative 'fun'

module Fun
  # parse pgn data
  class PGNParser
    def parse(files)
      f = Passant::PGN::File.new(ARGV.first)

      puts "Parsing PGN with #{f.games.size} games.."

      f.games.each do |g|
        puts "Parsing #{g.title}.."
        g.to_board
      end

      puts 'Done.'
    end
  end

  # store board state
  class ChessBoard
    START = [
      ['R', 'P', nil, nil, nil, nil, 'p', 'r'],
      ['N', 'P', nil, nil, nil, nil, 'p', 'n'],
      ['B', 'P', nil, nil, nil, nil, 'p', 'b'],
      ['Q', 'P', nil, nil, nil, nil, 'p', 'q'],
      ['K', 'P', nil, nil, nil, nil, 'p', 'k'],
      ['B', 'P', nil, nil, nil, nil, 'p', 'b'],
      ['N', 'P', nil, nil, nil, nil, 'p', 'n'],
      ['R', 'P', nil, nil, nil, nil, 'p', 'r']
    ]

    def initialize
      return START
    end
  end

  # play progress
  class ChessGame
    def play
      board = ChessBoard.new
      board.each do |row|
        puts row.inspect
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Fun

  game = ChessGame.new
  game.play
end
