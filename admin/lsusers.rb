#!/usr/bin/ruby -w
# lsusers.rb
# Author: Andy Bettisworth
# Description: Get users from /etc/passwd

require_relative 'admin'

module Admin
  def users
    raw_user_list = File.readlines('/etc/passwd')
    user_json = []

    raw_user_list.each_with_index do |user, index|
      user_attr = user.split(':')
      user_hash = {}

      user_hash[:id]             = index.to_i
      user_hash[:username]       = user_attr[0]
      user_hash[:password]       = user_attr[1]
      user_hash[:user_id]        = user_attr[2].to_i
      user_hash[:group_id]       = user_attr[3].to_i
      user_hash[:user_info]      = user_attr[4]
      user_hash[:home_directory] = user_attr[5].chomp
      user_hash[:login_shell]    = user_attr[6].chomp

      user_json << user_hash
    end
    user_json.sort! { |x, y| x[:user_id] <=> y[:user_id] }

    user_json
  end

  def print_users
    all_users = users

    all_users.each do |u|
      user = <<-USER
  (#{u[:user_id]}) #{u[:username]}
      USER
      puts user
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin

  print_users
end
