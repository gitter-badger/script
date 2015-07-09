#!/usr/bin/env ruby -w
# asciitrails.rb
# Author: Andy Bettisworth
# Description: Walk the ASCII trails

module AsciiTrails
  require 'io/console'
  require 'yaml'

  attr_accessor :history

  class Game
    def start
      puts 'You are now walking the ASCII trails'
      @history = []
      loop do
        move = get_move
        case move
        when "\e[A"
          @history << "MOVE UP"
          puts "[#{@history.count}] MOVE ARROW"
        when "\e[B"
          @history << "MOVE DOWN"
          puts "[#{@history.count}] MOVE DOWN"
        when "\e[C"
          @history << "MOVE RIGHT"
          puts "[#{@history.count}] MOVE RIGHT"
        when "\e[D"
          @history << "MOVE LEFT"
          puts "[#{@history.count}] MOVE LEFT"
        when "\u0003"
          @history << "PAUSE"
          puts "[#{@history.count}] CONTROL-C"
          save_game
          exit 0
        end
      end
    end

    private

    def get_move
      STDIN.echo = false
      STDIN.raw!

      input = STDIN.getc.chr
      if input == "\e" then
        input << STDIN.read_nonblock(3) rescue nil
        input << STDIN.read_nonblock(2) rescue nil
      end
    ensure
      STDIN.echo = true
      STDIN.cooked!

      return input
    end

    def save_game
      yaml = YAML::dump(self)
      file = File.open("./asciitrails.yml", 'w+') {|f| f.write yaml.to_yaml}
      exit
    end

    def load_game
      data = File.open("./asciitrails.yml", "r") {|f| f.read}
      yaml = YAML::load(data)
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
