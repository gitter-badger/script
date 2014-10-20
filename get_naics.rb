#!/usr/bin/env ruby -w
# get_naics.rb
# Author: Andy Bettisworth
# Description: Return NAICS Code generated from user Q and A session

require 'yaml'

data = YAML.load_file "#{ENV['HOME']}/.sync/.template/1_features/naics_codes.yaml"

two_digits   = data.select { |code, desc| code.to_s.size == 2 }
three_digits = data.select { |code, desc| code.to_s.size == 3 }
four_digits  = data.select { |code, desc| code.to_s.size == 4 }
five_digits  = data.select { |code, desc| code.to_s.size == 5 }
six_digits   = data.select { |code, desc| code.to_s.size == 6 }

two_digits.each { |code, desc| puts "#{code} #{desc}" }
puts ""
puts "Select a 2 digit NAICS code:"
two_code = gets.to_i until two_code
puts ""

three_digits.select! { |code| code.to_s =~ /^#{two_code}/ ? true : false }
three_digits.each { |code, desc| puts "#{code} #{desc}" }
puts ""
puts "Select a 3 digit NAICS code:"
three_code = gets.to_i
puts ""

four_digits.keep_if { |code, desc| /^#{three_code}/ =~ code.to_s }
four_digits.each { |code, desc| puts "#{code} #{desc}" }
puts ""
puts "Select a 4 digit NAICS code:"
four_code = gets.to_i until four_code

five_digits.keep_if { |code, desc| /^#{four_code}/ =~ code.to_s }
five_digits.each { |code, desc| puts "#{code} #{desc}" }
puts ""
puts "Select a 5 digit NAICS code:"
five_code = gets.to_i until five_code

six_digits.keep_if { |code, desc| /^#{five_code}/ =~ code.to_s }
six_digits.each { |code, desc| puts "#{code} #{desc}" }
puts ""
puts "Select a 6 digit NAICS code:"
six_code = gets.to_i until six_code

puts ""
puts "#{two_code} #{data[two_code]}"
puts "#{three_code} #{data[three_code]}"
puts "#{four_code} #{data[four_code]}"
puts "#{five_code} #{data[five_code]}"
puts "#{six_code} #{data[six_code]}"
