#!/usr/bin/env ruby
# screencast.rb
# Author: Andy Bettisworth
# Created At: 2015 0521 182728
# Modified At: 2015 0521 182728
# Description: Record a window as a PNG and JSON metadata

require 'optparse'
require 'fileutils'

require_relative 'wm'
require_relative 'screenshot'

module Admin
  module WindowManager
    class Screencast
      attr_accessor :window
      attr_accessor :timeout
      attr_accessor :delay
      attr_accessor :output

      def start!
        puts "Starting Capture"
        puts "================"

        setup_project

        # > cleanup param passing
        # screen   = Screenshot.new(query: @window) if @window
        # screen ||= Screenshot.new
        # while true do
        #   screen.save
        #   sleep(1.0/6)
        # end
      end

      private

      def setup_project
        name = 'screencast'
        dir  = "#{ENV['HOME']}/Desktop/#{name}"
        FileUtils.rmdir(dir)
        FileUtils.mkdir(dir)
        Dir.chdir(dir)
      end

      def encode
        # > create packed png
        # > create timeline
      end
    end
  end
end

if __FILE__ == $0
  include Admin::WindowManager

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: screencast [options]"

    opts.on('-w', '--window WINDOW', 'Record a specific window.') do |regexp|
      options[:window] = regexp
    end

    opts.on('-t', '--timeout MINUTES', 'Timeout after N minutes.') do |minutes|
      options[:timeout] = minutes
    end

    opts.on('-d', '--delay SECONDS', 'Set delay before looping animation.') do |seconds|
      options[:delay] = seconds
    end

    opts.on('-n', '--name NAME', 'Give output files a name.') do |name|
      options[:name] = name
    end
  end
  option_parser.parse!

  ep = Screencast.new
  ep.window  = options[:window]  if options[:window]
  ep.timeout = options[:timeout] if options[:timeout]
  ep.delay   = options[:delay]   if options[:delay]
  ep.name    = options[:name]    if options[:name]
  ep.start!

  # > default is start recording entire desktop until process is killed output to desktop
  # > accept pid, window ID, and regexp
  # > output <name>_anim.js and <name>_packed.png
  # > end_frame_pause delay, how long to way for before loop (4000)
  # > simplification_tolerance, how many pixels able to waste in crush (512)
end
