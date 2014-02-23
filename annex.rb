#!/usr/bin/ruby -w
# annex.rb
# Author: Andy Bettisworth
# Description: Sync [.script, .canvas, .template] with Annex

require 'optparse'

class Annex
  HOME = ENV['HOME']
  SYNC = "#{ENV['HOME']}/.sync"
  ANNEX = "/media/Annex/preseed/seed/.sync"

  def remote
    raise 'USB Annex not found.' unless File.exist?(ANNEX)
    system <<-EOF
cd #{SYNC}/.canvas;
git push origin master;
cd #{SYNC}/.script;
git push origin master;
cd #{SYNC}/.template;
git push origin master;
cd #{HOME}/.rbenv;
git push origin master;
    EOF
  end

  def local
    raise 'USB Annex not found.' unless File.exist?(ANNEX)
    system <<-EOF
cd #{SYNC}/.canvas;
git pull --rebase origin master;
cd #{SYNC}/.script;
git pull --rebase origin master;
cd #{SYNC}/.template;
git pull --rebase origin master;
cd #{HOME}/.rbenv;
git pull --rebase origin master;
    EOF
  end
end

## USAGE
# annex --push
# annex --pull

options = {}
option_parser = OptionParser.new do |opts|
  executable_name = File.basename($PROGRAM_NAME, ".rb")
  opts.banner = "Usage: #{executable_name} OPTION..."

  opts.on('--pull', 'bring local repo up to date with Annex remote') do
    options[:pull] = true
  end

  opts.on('--push', 'bring Annex up to date with local repo') do
    options[:push] = true
  end
end
option_parser.parse!

update = Annex.new
if options[:push] == true
  update.remote
elsif options[:pull] == true
  update.local
else
  puts option_parser.help
end
