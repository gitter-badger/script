#!/usr/bin/env ruby -w
# rbdelete.rb
# Description: Delete an rbscript

HOME = ENV['HOME']

## SET target script_name
name = ARGV[0].chomp.downcase if ARGV[0]
unless name
  puts "What script are you deleting?"
  name = STDIN.gets.chomp.downcase.gsub(" ", "_")
end
name.include?(".rb") ? target_script = name : target_script = name + ".rb"

## DELETE target script
`sudo rm -f #{HOME}/.sync/.script/#{target_script}`

## DELETE target alias
transfer_bash_aliases = String.new
name.include?(".rb") ? target_alias = name.chomp(".rb") : target_alias = name
old_alias = %Q{alias #{target_alias}="ruby #{HOME}/.sync/.script/#{target_script}"}
old_bash_aliases = File.open("#{HOME}/.bash_aliases","r")
old_bash_aliases.each_line {|line| transfer_bash_aliases << line unless line.include?(old_alias)}
old_bash_aliases.close
new_bash_aliases = File.open("#{HOME}/.bash_aliases","w")
new_bash_aliases.write(transfer_bash_aliases)
new_bash_aliases.close

## UPDATE system
system "source #{HOME}/.bash_aliases"
system "exec $SHELL"

## READ success
puts target_script + ' successfully removed from rbscripts.'
