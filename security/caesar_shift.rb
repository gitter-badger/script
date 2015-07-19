#!/usr/bin/ruby -w
# caesar_shift.rb
# Author: Andy Bettisworth
# Description: Caesar Shift Cipher interpreter

require_relative 'security'

module Security
  # caeser shift cipher
  class CaesarShiftCipher
    ALPHABET = ('a'...'z').to_a

    attr_accessor :shift_count

    def initialize(shift = 0)
      while shift > 25
        shift -= 25
      end

      self.shift_count = shift
    end

    def encrypt(raw_message)
      encrypted_message = ''

      raw_message.each_char do |char|
        current_char_index = ALPHABET.find_index { |x| /#{x}/i.match(char) }

        if current_char_index.nil?
          encrypted_message += char
        else
          new_char_index = current_char_index + @shift_count

          while new_char_index > 25
            new_char_index -= 25
          end

          encrypted_message += ALPHABET[new_char_index]
        end
      end

      encrypted_message
    end

    def decrypt(raw_message)
      decrypted_message = ''

      raw_message.each_char do |char|
        current_char_index = ALPHABET.find_index { |x| /#{x}/i.match(char) }

        if current_char_index.nil?
          decrypted_message += char
        else
          new_char_index = current_char_index - @shift_count

          while new_char_index > 25
            new_char_index -= 25
          end

          decrypted_message += ALPHABET[new_char_index]
        end
      end

      decrypted_message
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Security
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: caesar_shift [-d/-e] SHIFT_COUNT MESSAGE'

    opts.on('-e', '--encrypt SHIFT_COUNT', 'Encrypt your message') do |shift_count|
      options[:encrypt] = shift_count.to_i
    end

    opts.on('-d', '--decrypt SHIFT_COUNT', 'Decrypt your message') do |shift_count|
      options[:decrypt] = shift_count.to_i
    end
  end
  option_parser.parse!

  if options[:encrypt]
    cipher = CaesarShiftCipher.new(options[:encrypt])
    puts cipher.encrypt(ARGV[0])
  elsif options[:decrypt]
    cipher = CaesarShiftCipher.new(options[:decrypt])
    puts cipher.decrypt(ARGV[0])
  else
    puts option_parser
  end
end
