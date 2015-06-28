#!/usr/bin/env ruby
# userstat.rb
# Author: Andy Bettisworth
# Created At: 2015 0628 033805
# Modified At: 2015 0628 033805
# Description: print user status

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
      status[:inactivity]           = s if i == 5
    end

    status
  end

  def print_user_status(user=ENV['USER'])
    stat = user_status(user)

    puts <<-STATUS
#{stat[:username]}
  #{stat[:password_status]}
  #{stat[:password_modified_at]}
  # > how many days ago from now?
  #{stat[:minimum_age]} minimum password age
  #{stat[:maximum_age]} maximum password age
  #{stat[:inactivity]} of inactivity
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
