#!/usr/bin/env ruby -w
# screenshot.rb
# Author: Andy Bettisworth
# Description: Take screenshot of desktop or target window

require 'optparse'

require_relative 'wm'

module Admin
  module WindowManager
    class Screenshot
      def save(window: 'root', name: 'desktop')
        window(window) if window not
        # > query for window id if window kwargs
        filename = "#{name}_#{Time.now.to_i}"
        `import -window #{window} #{filename}.png`
      end
    end
  end
end

if __FILE__ == $0
  # >
end
