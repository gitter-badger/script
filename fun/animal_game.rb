#!/usr/bin/ruby -w
# animal_game.rb
# Author: Andy Bettisworth
# Description: Play the animal game (idea from Jim Weireck

require_relative 'fun'

module Fun
  class AnimalGame
    def play
      puts 'Think of an animal...'
      puts 'Is it an dog? (yes or no)'
      correct_guess = /y/i.match(gets)

      if correct_guess
        puts 'I win. Lucky guess on my part.'
        puts 'Play again? (yes or no)'
        # redo

      else
        puts 'You win. Help me learn from my mistake before you go...'
        puts 'What animal were you thinking of?'

        until actual_animal
          actual_animal = gets.chomp
        end

        puts "Give me a question to distinguash a #{actual_animal} from an #{computer_guess}"
        differentiating_question = gets.chomp
        puts "For a #{actual_animal}, what is the answer to your question? (yes or no)"
        differentiating_question_answer = gets.chomp

        puts 'Thanks.'

        puts 'Play again? (yes or no)'
        # redo
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Fun

  game = AnimalGame.new
  game.play
end
