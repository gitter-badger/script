#!/usr/bin/env ruby -w
# screenshot.rb
# Author: Andy Bettisworth
# Description: Take screenshot of desktop or target window

require 'optparse'

require_relative 'wm'

module Admin
  module WindowManager
    class Screenshot
      attr_accessor :query
      attr_accessor :outfile

      def save
        if @query
          screen = window(@query)
          screen = screen[:id] if screen[:id]
        else
          screen = 'root'
        end

        if @outfile
          outfile = @outfile
        else
          outfile = 'desktop'
        end
        filename = "#{outfile}_#{Time.now.to_i}"

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

    opts.on('-q', '--query WINDOW', 'Capture a specific window.') do |query|
      options[:query] = query
    end

    opts.on('-o', '--outfile FILENAME', 'Name of screenshot.') do |string|
      options[:outfile] = string
    end
  end
  option_parser.parse!

  screen = Screenshot.new
  screen.query   = options[:query]    if options[:query]
  screen.outfile = options[:outfile]  if options[:outfile]
  screen.save
end
