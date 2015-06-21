#!/usr/bin/env ruby
# unlock_sysfiles.rb
# Author: Andy Bettisworth
# Created At: 2015 0620 202652
# Modified At: 2015 0620 202652
# Description: unlock static system files

require_relative 'security'

module Security
  class SystemFiles
    def self.unlock
      STATIC_DIR.each do |dir|
        puts "Unlocking #{dir}..."
        `sudo chattr -VR -i #{dir}`
      end
    end
  end
end

if __FILE__ == $0
  include Security
  SystemFiles.unlock
end
