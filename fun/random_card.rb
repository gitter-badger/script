#!/usr/bin/ruby -w
# random_card.rb
# Author: Andy Bettisworth
# Description: Read a random card

require_relative 'fun'

module Fun
  # generate a random card
  class CardDeck
    CARD_TYPE = ['One','Two','Three','Four','Five','Six','Seven','Eight','Nine','Ten','Jack','Queen','King','Ace']
    CARD_SUITE = ['Spade', 'Club', 'Diamond', 'Heart']

    attr_reader :deck

    def initialize
      @deck = []

      CARD_TYPE.each do |card_type|
        CARD_SUITE.each do |suite|
          @deck << "#{card_type} of #{suite}s"
        end
      end
    end

    def blind_pick
      @deck.shuffle!
      puts @deck.pop
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Fun

  deck = CardDeck.new
  deck.blind_pick
end
