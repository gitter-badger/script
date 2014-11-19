#!/usr/bin/env ruby -w
# ipodsync.rb
# Author: Andy Bettisworth
# Created At: 2014 1119 031644
# Modified At: 2014 1119 031644
# Description: sync my ipod with my desktop files

class IpodSync
  def start(music_dir)
    # > TODO
  end
end

if __FILE__ == $0
  if ARGV.count <= 1
    sync = IpodSync.new
    sync.start(ARGV[0])
  else
    STDERR.puts "USAGE: ipodsync MUSIC_DIR"
    exit 1
  end
end