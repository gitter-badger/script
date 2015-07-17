#!/usr/bin/env ruby
# get_passwd.rb
# Author: Andy Bettisworth
# Description: To get Hash of /etc/passwd

require_relative 'admin'

module Admin
  # Read from /etc/passwd
  class GetPasswd
    KEYS = ['username', 'password', 'uid', 'gid', 'full_name', 'home_dir', 'shell']

    def get
      user_array = []
      passwd_file = File.open('/etc/passwd', 'r')

      passwd_file.readlines.each do |ln|
        user_hash = {}
        user = ln.split(':')

        user.each_with_index { |x, i| user_hash[KEYS[i].to_sym] = x }
        user_array << user_hash
      end

      user_array
    end

    def print
      users = get

      users.each do |acct|
        user_str = ''

        acct.each do |k, v|
          if [:username, :uid, :full_name, :home_dir].include?(k)
            user_str += "#{v.strip} "
          end
        end

        puts user_str
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin

  getter = GetPasswd.new
  getter.print
end
