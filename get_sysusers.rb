#!/usr/bin/ruby -w
# get_sysusers.rb
# Author: Andy Bettisworth
# Description: GET the system users from /etc/passwd

require 'yaml'

user_list = File.readlines('/etc/passwd')

user_list.each_with_index do |user, index|
  puts index + "\n" + user
  puts "\n"

  # user_attributes =  user.split(':')

  # # > CREATE sub-user hash user can contain [full_name, phone, email, location]
  # user_hash = {}
  # user_hash[:username] = user_attributes[0]
  # user_hash[:password] = user_attributes[1]
  # user_hash[:user_id] = user_attributes[2]
  # user_hash[:group_id] = user_attributes[3]
  # user_hash[:user_info] = user_attributes[4]
  # user_hash[:home_directory] = user_attributes[5]
  # user_hash[:login_shell] = user_attributes[6]

  # File.open("current_users-#{Time.now.strftime('%Y%M%d%H%M%S')}.yaml", 'a') { |f| YAML.dump(user_hash, f) }
end

