#!/usr/bin/env ruby
# lock_sysfiles.rb
# Author: Andy Bettisworth
# Created At: 2015 0620 202625
# Modified At: 2015 0620 202625
# Description: lockdown static system files

require_relative 'security'

module Security
  class SystemFiles
    def self.lock
      STATIC_DIR.each do |dir|
        `sudo chattr -VR +i #{dir}/*`
      end
    end
  end
end

if __FILE__ == $0
  include Security
  SystemFiles.lock
end
