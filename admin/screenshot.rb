#!/usr/bin/env ruby -w
# screenshot.rb
# Author: Andy Bettisworth
# Description: Take screenshot of desktop or target window

require 'optparse'

require_relative 'wm'

module Admin
  module WindowManager
    class Screenshot
      def initialize
        # >
      end

      def save(query: 'root', name: 'desktop')
        unless query == 'root'
          screen = window(query)
          screen = screen[:id] if screen[:id]
        else
          screen = query
        end

        filename = "#{name}_#{Time.now.to_i}"

        `import -window #{screen} #{filename}.png`
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
      options[:query] = query
    end

    opts.on('-n', '--name NAME', 'Give screenshot a name.') do |name|
      options[:name] = name
    end
  end
  option_parser.parse!

  # > move window selection to initialize method
  screen = Screenshot.new

  param = {}
  param[:query] = options[:query] if options[:query]
  param[:name]  = options[:name] if options[:name]

  screen.save(param)
end
