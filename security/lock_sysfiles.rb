#!/usr/bin/env ruby
# lock_sysfiles.rb
# Author: Andy Bettisworth
# Created At: 2015 0620 202625
# Modified At: 2015 0620 202625
# Description: lockdown static system files

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'security/security'

module Security
  # lock system files
  class SystemFiles
    include Admin
    
    def self.lock
      STATIC_DIR.each do |dir|
        puts "Locking #{dir}..."
        `sudo chattr -VR +i #{dir}`
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Security

  SystemFiles.lock
end
