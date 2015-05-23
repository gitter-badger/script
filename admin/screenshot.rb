#!/usr/bin/env ruby -w
# screenshot.rb
# Author: Andy Bettisworth
# Description: Take screenshot of desktop or target window

module Admin
  module WindowManager
    class Screenshot
      def save(window: 'root', name: 'desktop')
        filename = "#{name}_#{Time.now.to_i}"
        `import -window #{window} #{filename}.png`
      end
    end
  end
end

if __FILE__ == $0
  # >
end
