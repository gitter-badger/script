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
        # > query for window id if window kwargs
        # window(window) if window
        window_id = '0x034014f9'

        filename = "#{name}_#{Time.now.to_i}"

        `import -window #{window_id} #{filename}.png`
      end
    end
  end
end

if __FILE__ == $0
  include Admin::WindowManager

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: screenshot [options]"

    opts.on('-w', '--window WINDOW', 'Capture a specific window.') do |query|
      options[:window] = query
    end

    opts.on('-n', '--name NAME', 'Give screenshot a name.') do |name|
      options[:name] = name
    end
  end
  option_parser.parse!

  screen = Screenshot.new

  param  = {}
  param[:window] = options[:window] if options[:window]
  param[:name]   = options[:name] if options[:name]

  screen.save(param)
end
