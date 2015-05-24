#!/usr/bin/env ruby
# screencast.rb
# Author: Andy Bettisworth
# Created At: 2015 0521 182728
# Modified At: 2015 0521 182728
# Description: Record a window as a PNG and JSON metadata

require 'optparse'
require 'fileutils'

require_relative 'wm'

module Admin
  module WindowManager
    class Screencast
      attr_accessor :query
      attr_accessor :name
      attr_accessor :timeout
      attr_accessor :delay

      def require_recordmydesktop
        `which recordmydesktop`
        unless $? == 0
          raise StandardError, 'The recordmydesktop application is required.'
        end
      end

      def start!
        require_recordmydesktop

        puts "Starting Capture"
        puts "================"

        cmd = build_command
        `#{cmd}`
      end

      private

      def build_command
        cmd  = ""
        cmd += " timeout 10s" unless @timeout
        cmd += " timeout #{@timeout}" if @timeout
        cmd += " recordmydesktop"
        if @query
          screen = window(@query)
          if screen[:id]
            cmd += "# --windowid #{screen[:id]}"
          end
        end
        cmd += " --no-frame"
        cmd += " --overwrite"
        if @v_quality
          if (0..63).include?(@quality)
            cmd += " --v_quality #{@quality}" if @quality.is_a? Integer
          end
        else
          cmd += " --v_quality 35"
        end
        if @no_sound
          cmd += " --no-sound"
        end
        if @no_cursor
          cmd += " --no-cursor"
        end
        if @follow_mouse
          cmd += " --follow-mouse"
        end
        if @width
          cmd += " --width #{@width}" if @width.is_a? Integer
        end
        if @height
          cmd += " --height #{@height}" if @height.is_a? Integer
        end
        cmd += " -o #{@name}" if @name
        cmd
      end
    end
  end
end

if __FILE__ == $0
  include Admin::WindowManager

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: screencast [options]"

    opts.on('-w', '--window QUERY', 'Record a specific window.') do |query|
      options[:query] = query
    end

    opts.on('-n', '--name NAME', 'Give output files a name.') do |name|
      options[:name] = name
    end

    opts.on('-t', '--timeout TIME', 'Timeout after N minutes.') do |time|
      options[:timeout] = time
    end
  end
  option_parser.parse!

  ep = Screencast.new
  ep.query   = options[:query]   if options[:query]
  ep.name    = options[:name]    if options[:name]
  ep.timeout = options[:timeout] if options[:timeout]
  ep.start!
end
