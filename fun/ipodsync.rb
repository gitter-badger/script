#!/usr/bin/env ruby -w
# ipodsync.rb
# Author: Andy Bettisworth
# Created At: 2014 1119 031644
# Modified At: 2014 1119 031644
# Description: sync my ipod with my desktop files

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'fun/fun'

module Fun
  # sync ~/Music with ipod
  class IpodSync
    include Admin
    
    def start
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Fun

  if ARGV.count <= 1
    sync = IpodSync.new
    sync.start(ARGV[0])
  else
    STDERR.puts 'USAGE: ipodsync MUSIC_DIR'
    exit 1
  end
end
