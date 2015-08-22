#!/usr/bin/env ruby
# unlock_sysfiles.rb
# Author: Andy Bettisworth
# Created At: 2015 0620 202652
# Modified At: 2015 0620 202652
# Description: unlock static system files

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'security/security'

module Security
  # unlock system files
  class SystemFiles
    include Admin
    
    def self.unlock
      STATIC_DIR.each do |dir|
        puts "Unlocking #{dir}..."
        `sudo chattr -VR -i #{dir}`
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Security

  SystemFiles.unlock
end
