#!/usr/bin/env ruby -w
# asciitrails.rb
# Author: Andy Bettisworth
# Description: Walk the ASCII trails

module AsciiTrails
  MOVES = {
    "\e[A": "UP ARROW",
    "\e[B": "DOWN ARROW",
    "\e[C": "RIGHT ARROW",
    "\e[D": "LEFT ARROW",
    "\u0003": "CONTROL-C"
  }

  class Game
    def start
      puts 'You are now walking the ASCII trails'
      move = get_move
      if MOVES[move]
        puts MOVES[move]
      else 
        puts 'Try again'
      end
    end
    
    private

    def get_move
      input = STDIN.getc.chr
      return input
    end
  end
 
  class Board
  end
end

if __FILE__ == $0
  include AsciiTrails

  game = Game.new
  game.start
end
