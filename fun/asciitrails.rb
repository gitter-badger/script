#!/usr/bin/env ruby -w
# asciitrails.rb
# Author: Andy Bettisworth
# Description: Walk the ASCII trails

require 'io/console'
require 'yaml'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'fun/fun'

module Fun
  # walk the ascii trails
  module AsciiTrails
    include Admin

    attr_accessor :history

    class Game
      def start
        puts 'You are now walking the ASCII trails.'
        load_game
        game_loop
      end

      private

      def game_loop
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
            puts "[#{@history.count}] PAUSE"
            save_game
            exit 0
          end
        end
      end

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
        File.open('./asciitrails.yml', 'w') { |f| YAML.dump([] << self, f) }
        exit
      end

      def load_game
        yaml = YAML.load_file('./asciitrails.yml')
        @history = yaml[0].history
      rescue
        @history = []
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Fun

  game = Game.new
  game.start
end
