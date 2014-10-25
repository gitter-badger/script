#!/usr/bin/env ruby -w
# get_naics.rb
# Author: Andy Bettisworth
# Description: Return NAICS Code generated from user Q and A session

require 'yaml'

class GetNAICSCode
  NAICS_CODES = YAML.load_file "#{ENV['HOME']}/.sync/.template/1_features/naics_codes.yaml"

  attr_accessor :two_digits
  attr_accessor :three_digits
  attr_accessor :four_digits
  attr_accessor :five_digits
  attr_accessor :six_digits

  def initialize
    @two_digits   = NAICS_CODES.select { |code, desc| code.to_s.size == 2 }
    @three_digits = NAICS_CODES.select { |code, desc| code.to_s.size == 3 }
    @four_digits  = NAICS_CODES.select { |code, desc| code.to_s.size == 4 }
    @five_digits  = NAICS_CODES.select { |code, desc| code.to_s.size == 5 }
    @six_digits   = NAICS_CODES.select { |code, desc| code.to_s.size == 6 }
  end

  def ask
    # > stop after initial 0
    two_digit   = get_two_digit
    three_digit = get_three_digit(two_digit)
    four_digit  = get_four_digit(three_digit)
    five_digit  = get_five_digit(four_digit)
    six_digit   = get_six_digit(five_digit)
    # > display final selections
    display_selection_tree
  end

  private

  def get_two_digit
    @two_digits.each { |code, desc| puts "#{code} #{desc}" }
    puts ""
    puts "Select a 2 digit NAICS code:"
    two_code = gets.to_i until two_code
    two_code
  end

  def get_three_digit(two_digit)
    @three_digits.select! { |code| code.to_s =~ /^#{two_digit}/ ? true : false }
    @three_digits.each { |code, desc| puts "#{code} #{desc}" }
    puts ""
    puts "Select a 3 digit NAICS code:"
    three_code = gets.to_i until three_code
    three_code
  end

  def get_four_digit(three_digit)
    @four_digits.keep_if { |code, desc| /^#{three_digit}/ =~ code.to_s }
    @four_digits.each { |code, desc| puts "#{code} #{desc}" }
    puts ""
    puts "Select a 4 digit NAICS code:"
    four_code = gets.to_i until four_code
    four_code
  end

  def get_five_digit(four_digit)
    @five_digits.keep_if { |code, desc| /^#{four_digit}/ =~ code.to_s }
    @five_digits.each { |code, desc| puts "#{code} #{desc}" }
    puts ""
    puts "Select a 5 digit NAICS code:"
    five_code = gets.to_i until five_code
    five_code
  end

  def get_six_digit(five_digit)
    @six_digits.keep_if { |code, desc| /^#{five_digit}/ =~ code.to_s }
    @six_digits.each { |code, desc| puts "#{code} #{desc}" }
    puts ""
    puts "Select a 6 digit NAICS code:"
    six_code = gets.to_i until six_code
    six_code
  end

  def display_selection_tree
    puts ""
    puts "#{two_code}     #{NAICS_CODES[two_code]}"
    puts "#{three_code}     #{NAICS_CODES[three_code]}"
    puts "#{four_code}    #{NAICS_CODES[four_code]}"
    puts "#{five_code}   #{NAICS_CODES[five_code]}"
    puts "#{six_code}  #{NAICS_CODES[six_code]}"
  end
end

questions = GetNAICSCode.new
questions.ask
