#!/usr/bin/env ruby -w
# rbnew.rb
# Description: Create an rbscript

HOME = ENV['HOME']

## SET script name
name = ARGV[0].downcase if ARGV[0]
unless name
  puts "Name your script: "
  name = gets.chomp.downcase.gsub(" ", "_")
end
script = name + ".rb" unless name.include?(".rb")

## SET script description
puts "What does this script do?"
description = STDIN.gets.chomp.downcase

## CREATE script UNLESS exists
fail "WARNING: Script already exists." if File.exist?("#{HOME}/.sync/.script/#{script}")
rbscript = File.open("/tmp/" + script,"w")
rbscript.chmod(0755)
shebang_header = <<-SCRIPT
#!/usr/bin/env ruby -w
# #{script}
# Description: #{description}

SCRIPT
rbscript.write(shebang_header)
rbscript.close

## UPDATE /home/wurde/.bash_aliases
new_alias = %Q{alias #{name}="ruby #{HOME}/.sync/.script/#{script}"}
system "sudo echo '#{new_alias}' >> #{HOME}/.bash_aliases"

## EXEC open script
system "sudo mv /tmp/#{script} #{HOME}/.sync/.script/"
until File.exist?("#{HOME}/.sync/.script/#{script}")
  sleep 1
end
system "source #{HOME}/.bash_aliases"
system "exec $SHELL"
sleep 1
system "sudo vi #{HOME}/.sync/.script/#{script}"