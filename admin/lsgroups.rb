#!/usr/bin/ruby -w
# lsgroups.rb
# Author: Andy Bettisworth
# Description: Get groups from /etc/groups

module Admin
  def groups
    raw_group_list = File.readlines('/etc/group')
    group_json = []

    raw_group_list.each_with_index do |group, index|
      group_attr = group.split(':')
      group_hash = {}

      group_hash[:id]        = index.to_i
      group_hash[:groupname] = group_attr[0]
      group_hash[:password]  = group_attr[1]
      group_hash[:group_id]  = group_attr[2].to_i
      group_hash[:members]   = group_attr[3].strip.split(',')

      group_json << group_hash
    end
    group_json.sort! { |x,y| x[:group_id] <=> y[:group_id] }

    group_json
  end

  def print_groups
    all_groups = groups

    all_groups.each do |g|
      group  = ''
      group += "(#{g[:group_id]}) #{g[:groupname]}"
      group += " #{g[:members].inspect}" if g[:members].count > 0
      puts group
    end
  end
end

if __FILE__ == $0
  include Admin
  print_groups
end
