#!/usr/bin/env ruby -w
# setup_script.rb
# Author: Andy Bettisworth
# Description: CREATE aliases for ~/.sync/.script/* via ~/.bash_aliases

class SetupScripts
  USER = ENV['USER']
  HOME = ENV['HOME']
  BASH_ALIASES = "#{HOME}/.bash_aliases"

  def run
    system "sudo rm -f #{BASH_ALIASES}"

    bash_aliases = File.open(BASH_ALIASES, 'a')
    bash_aliases.puts '## CREATE aliases for ~/.sync/.script/* via ~/.bash_aliases'

    ruby_scripts = Dir["#{HOME}/.sync/.script/*.rb"]
    ruby_scripts.each do |script|
      # IF file ends with '_spec.rb' THEN it is ignored
      next if script.include?("_spec.rb")
      name = File.basename(script, '.rb')
      str_a1 = "alias #{name}="
      str_a2 = "'ruby "
      str_a3 = "#{script}'"
      str_alias = str_a1 + str_a2 + str_a3
      bash_aliases.puts str_alias
    end
    bash_aliases.close

    system "sudo chmod 755 #{BASH_ALIASES}"
    system "sudo chown #{USER}:#{USER} #{BASH_ALIASES}"
    system "source #{BASH_ALIASES}"
  end
end

if __FILE__ == $0
  mgmt = SetupScripts.new
  mgmt.run
end
