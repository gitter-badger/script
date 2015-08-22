#!/usr/bin/ruby -w
# get_weekdays.rb
# Author: Andy Bettisworth
# Description: Get the weekdays based on current day

require 'date'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

if __FILE__ == $PROGRAM_NAME
  WEEKDAYS = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
  weekdays = {
    1 => WEEKDAYS[0],
    2 => WEEKDAYS[1],
    3 => WEEKDAYS[2],
    4 => WEEKDAYS[3],
    5 => WEEKDAYS[4],
    6 => WEEKDAYS[5],
    7 => WEEKDAYS[6]
  }

  current_day = Date.today
  current_day_index = current_day.cwday

  weekdays[current_day_index] = current_day
  weekdays.each do |index, day|
    if weekdays[index].kind_of? String
      days_from_current = (current_day_index - index).abs
      if current_day_index > index
        weekdays[index] = current_day - days_from_current
      else
        weekdays[index] = current_day + days_from_current
      end
    end
  end

  weekdays.each do |index, day|
    puts "#{day} is a #{WEEKDAYS[index - 1]}"
  end
end
