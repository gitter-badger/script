#!/usr/bin/env ruby
# userstat.rb
# Author: Andy Bettisworth
# Created At: 2015 0628 033805
# Modified At: 2015 0628 033805
# Description: print user status

require 'date'

module Admin
  def user_status(user=ENV['USER'])
    raw_status = `sudo passwd --status #{user}`
    status = {}

    raw_status.split.each_with_index do |s, i|
      status[:username]             = s if i == 0
      status[:password_status]      = s if i == 1
      status[:password_modified_at] = s if i == 2
      status[:minimum_age]          = s if i == 3
      status[:maximum_age]          = s if i == 4
      status[:warning_period]       = s if i == 5
      status[:inactivity]           = s if i == 6
    end

    status
  end

  def print_user_status(user=ENV['USER'])
    stat = user_status(user)
    pass_modified_at = Date.strptime(stat[:password_modified_at], '%m/%d/%Y')
    pass_state = case stat[:password_status]
    when 'P' then 'Good password'
    when 'L' then 'Locked password'
    when 'NP' then 'No password'
    else 'Unknown'
    end

    puts <<-STATUS
#{stat[:username]}
  #{pass_state}...
  last modified #{(Date.today - pass_modified_at).to_i} days ago,
  #{stat[:minimum_age]} days required before change,
  at #{stat[:maximum_age]} days the password will expire,
  a warning will be sent #{stat[:warning_period]} days prior,
  with #{stat[:inactivity]} days of inactivity.
    STATUS
  end
end

if __FILE__ == $0
  include Admin

  if ARGV[0]
    print_user_status(ARGV[0])
  else
    print_user_status
  end
end
