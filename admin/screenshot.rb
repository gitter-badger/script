#!/usr/bin/env ruby -w
# screenshot.rb
# Author: Andy Bettisworth
# Description: Take screenshot of desktop or target window

module Admin
  module WindowManager
    class Screenshot
      def save
        # >
        filename = "screenshot_#{Time.now.to_i}.png"
        File.open("#{ENV['HOME']}/Desktop/#{filename}", 'w+')
      end
    end
  end
end

if __FILE__ == $0
  # >
end
