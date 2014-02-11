#!/usr/bin/ruby -w
# annex_sync.rb
# Author: Andy Bettisworth
# Description: Sync [.script, .canvas, .template] with Annex

require 'optparse'

class AnnexSync
  LOCAL_SYNC = "#{ENV['HOME']}/.sync"
  REMOTE_SYNC = "/media/Annex/preseed/seed/.sync"
  GITHUB_SYNC = "https://github.com/wurde"

  def remote
    raise 'USB Annex not found.' unless File.exist?(REMOTE_SYNC)
    system <<-EOF
cd #{LOCAL_SYNC}/.canvas;
git push origin master;
cd #{LOCAL_SYNC}/.script;
git push origin master;
cd #{LOCAL_SYNC}/.template;
git push origin master;
    EOF
  end

  def local
    raise 'USB Annex not found.' unless File.exist?(REMOTE_SYNC)
    system <<-EOF
cd #{LOCAL_SYNC}/.canvas;
git pull --rebase origin master;
cd #{LOCAL_SYNC}/.script;
git pull --rebase origin master;
cd #{LOCAL_SYNC}/.template;
git pull --rebase origin master;
    EOF
  end
end

## USAGE
# annex_sync --push
# annex_sync --pull

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

update = AnnexSync.new
if options[:push] == true
  update.remote
elsif options[:pull] == true
  update.local
else
  puts option_parser.help
end
