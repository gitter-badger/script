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
  attr_accessor :digit_array

  def initialize
    @two_digits   = NAICS_CODES.select { |code, desc| code.to_s.size == 2 }
    @three_digits = NAICS_CODES.select { |code, desc| code.to_s.size == 3 }
    @four_digits  = NAICS_CODES.select { |code, desc| code.to_s.size == 4 }
    @five_digits  = NAICS_CODES.select { |code, desc| code.to_s.size == 5 }
    @six_digits   = NAICS_CODES.select { |code, desc| code.to_s.size == 6 }
    @digit_array = [@two_digits, @three_digits, @four_digits, @five_digits, @six_digits]
  end

  def ask
    target_naics_code = 0
    @digit_array.each_with_index do |naics_codes, index|
      code = get_naics_code(naics_codes)
      break if code == 0
      filter(@digit_array[index+1], code) if index < 4
      target_naics_code = code
    end
    puts "Target NAICS Code: [#{target_naics_code}] #{NAICS_CODES[target_naics_code]}"
    target_naics_code
  end

  private

  def get_naics_code(code_list)
    code_list.each { |code, desc| puts "#{code} #{desc}" }
    puts ""
    puts "Select a #{code_list.keys[0].to_s.size} digit NAICS code:"
    two_code = gets.to_i until two_code
    two_code
  end

  def filter(code_list, digit_filter)
    code_list.select! { |code| code.to_s =~ /^#{digit_filter}/ ? true : false }
  end
end

questions = GetNAICSCode.new
questions.ask
