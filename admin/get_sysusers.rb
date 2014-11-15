#!/usr/bin/ruby -w
# get_sysusers.rb
# Author: Andy Bettisworth
# Description: GET the system users from /etc/passwd

require 'yaml'

if __FILE__ == $0
  raw_user_list = File.readlines('/etc/passwd')

  user_json = []
  raw_user_list.each_with_index do |user, index|
    user_attr = user.split(':')

    user_hash = {}
    user_hash[:id] = index.to_i
    user_hash[:username] = user_attr[0]
    user_hash[:password] = user_attr[1]
    user_hash[:user_id] = user_attr[2].to_i
    user_hash[:group_id] = user_attr[3].to_i
    user_hash[:user_info] = user_attr[4]
    user_hash[:home_directory] = user_attr[5].chomp
    user_hash[:login_shell] = user_attr[6].chomp

    user_json << user_hash
  end

  # filename = "current_users-#{Time.now.strftime('%Y%M%d%H%M%S')}.yaml"
  filename = "current_users.yaml"
  user_json.each do |user|
    File.open(filename, 'a') { |f| YAML.dump(user, f) }
  end
end
