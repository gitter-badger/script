#!/usr/bin/ruby -w
# add_commas_to_integers.rb
# Author: Andy Bettisworth
# Description: Add commas to integers

module Precision
  COMMIFY_DELIMITER = ','
  COMMIFY_DECIMAL = '.'
  COMMIFY_BREAKPOIN = 3
  COMMIFY_PAD100THIS = true

  def commify(args = {})
    args[:delimiter]        ||= COMMIFY_DELIMITER
    args[:breakpoint]       ||= COMMIFY_BREAKPOIN
    args[:decimal_pt]       ||= COMMIFY_DECIMAL
    args[:show_hundredths]  ||= COMMIFY_PAD100THIS

    int_as_string, float_as_string = to_s.split('.')

    int_out = format_int(
      int_as_string,
      args[:breakpoint],
      args[:delimiter]
    )

    float_out = format_float(
      float_as_string,
      args[:decimal_pt],
      args[:show_hundredths]
    )

    int_out + float_out
  end

  private

  def format_int(int_as_string, breakpoint, delimiter)
    reversed_groups = int_as_string.reverse.split(/(\d{#{breakpoint}})/)
    reversed_digits = reversed_groups.grep(/\d+/)
    digit_groups = reversed_digits.reverse.map { |unit| unit.reverse }
    digit_groups.join(delimiter)
  end

  def format_float(float_as_string, decimal_pt, show_hundredths)
    return '' unless float_as_string
    output = decimal_pt + float_as_string
    return output unless show_hundredths
    output += '0' if (float_as_string.size == 1)
    output
  end
end
