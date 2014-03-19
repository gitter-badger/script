#!/usr/bin/ruby -w
# solitaire_cipher_spec.rb
# Author: Andy Bettisworth
# Description: Code Kata
# LINK http://rubyquiz.com/quiz1.html

class SolitaireCipher
  attr_accessor :message

  def initialize(message)
    self.message = message
  end

  def encrypt
    clean
    upcase
    pad
    group
  end

 def decrypt
  end

  private

  def clean
    message.gsub!(/[^A-Za-z]/, '')
  end

  def upcase
    message.upcase!
  end

  def group
    self.message = message.scan(%r{.{5}})
  end

  def pad
    self.message = message + "X" * ((5 - message.size % 5) % 5)
  end
end

describe SolitaireCipher do
  let(:raw_message) { "This is my secret message." }
  let(:check_message) { "This is my secret message." }

  before :each do
    @game = SolitaireCipher.new(raw_message)
  end

  describe "#encrypt" do
    it "should remove any non A to Z characters" do
      @game.send(:clean)
      expect(@game.message).to eq(check_message.gsub!(/[^A-Za-z]/, ''))
    end

    it "should uppercase characters" do
      @game.send(:upcase)
      expect(@game.message).to eq(check_message.upcase!)
    end

    it "should split message into five character groups" do
      @game.send(:group)
      expect(@game.message).to eq(check_message.scan(%r{.{5}}))
    end

    it "should padding the last group with Xs as needed" do
      @game.encrypt
      expect(@game.message).to eq(["THISI", "SMYSE", "CRETM", "ESSAG", "EXXXX"])
    end
  end

  describe "#decrypt" do
  end
end
