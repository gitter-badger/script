#!/usr/bin/env ruby -w
# screenshot.rb
# Author: Andy Bettisworth
# Description: Take screenshot of desktop or target window

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'admin/wm'

module Admin
  module WindowManager
    # generate a screenshot
    class Screenshot
      attr_accessor :query
      attr_accessor :delay
      attr_accessor :outfile

      def save
        if @query
          screen = window(@query)
          @screen = screen[:id] if screen[:id]
        else
          @screen = 'root'
        end

        @outfile ||= 'desktop'
        @outfile = "#{@outfile}_#{Time.now.to_i}"

        cmd = build_command
        `#{cmd}`
      end

      def build_command
        cmd  = ''
        cmd += " sleep #{@delay};" if @delay
        cmd += " import -window #{@screen} #{@outfile}.png"
        cmd
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin::WindowManager
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: screenshot [options]'

    opts.on('-q', '--query WINDOW', 'Capture a specific window.') do |query|
      options[:query] = query
    end

    opts.on('-d', '--delay TIME', 'Delay screenshot for N seconds.') do |time|
      options[:delay] = time
    end

    opts.on('-o', '--outfile FILENAME', 'Name of screenshot.') do |string|
      options[:outfile] = string
    end
  end
  option_parser.parse!

  screen = Screenshot.new
  screen.query   = options[:query]   if options[:query]
  screen.delay   = options[:delay]   if options[:delay]
  screen.outfile = options[:outfile] if options[:outfile]
  screen.save
end
