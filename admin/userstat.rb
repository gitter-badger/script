#!/usr/bin/env ruby
# userstat.rb
# Author: Andy Bettisworth
# Created At: 2015 0628 033805
# Modified At: 2015 0628 033805
# Description: print user status

module Admin
  def user_status(user=ENV['USER'])
    raw_status = `sudo passwd --status #{user}`

    raw_status.split.each do |s|
      puts s + "\n"
    end
  end

  def print_user_status(user=ENV['USER'])
    stat = user_status(user)
    # > pretty print
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
