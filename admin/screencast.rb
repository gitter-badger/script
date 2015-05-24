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
      attr_accessor :v_quality
      attr_accessor :s_quality
      attr_accessor :no_sound
      attr_accessor :no_cursor
      attr_accessor :follow_mouse
      attr_accessor :width
      attr_accessor :height

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
            cmd += " --windowid #{screen[:id]}"
          end
        end
        cmd += " --no-frame"
        cmd += " --overwrite"
        if @v_quality
          if (0..63).include?(@v_quality)
            cmd += " --v_quality #{@v_quality}" if @v_quality.is_a? Integer
          end
        else
          cmd += " --v_quality 35"
        end
        if @s_quality
          if (-1..10).include?(@s_quality)
            cmd += " --s_quality #{@s_quality}" if @s_quality.is_a? Integer
          end
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

    opts.on('-q', '--query WINDOW', 'Record a specific window.') do |query|
      options[:query] = query
    end

    opts.on('-n', '--name NAME', 'Give output files a name.') do |name|
      options[:name] = name
    end

    opts.on('-t', '--timeout TIME', 'Timeout after N minutes.') do |time|
      options[:timeout] = time
    end

    opts.on('-v', '--v-quality INTEGER', 'Video encoding quality (0..63).') do |integer|
      options[:v_quality] = integer
    end

    opts.on('-s', '--s-quality INTEGER', 'Audio encoding quality (-1..10).') do |integer|
      options[:s_quality] = integer
    end

    opts.on('--no-sound', 'Do not record audio.') do
      options[:no_sound] = true
    end

    opts.on('--no-cursor', 'Do not include cursor.') do
      options[:no_cursor] = true
    end

    opts.on('-m', '--follow-mouse', 'Track the cursor movement.') do
      options[:follow_mouse] = true
    end

    opts.on('-w', '--width', 'Width of recorded window.') do |integer|
      options[:width] = integer
    end

    opts.on('-h', '--height', 'Height of recorded window.') do |integer|
      options[:height] = integer
    end
  end
  option_parser.parse!

  ep = Screencast.new
  ep.query        = options[:query]     if options[:query]
  ep.name         = options[:name]      if options[:name]
  ep.timeout      = options[:timeout]   if options[:timeout]
  ep.v_quality    = options[:v_quality] if options[:v_quality]
  ep.s_quality    = options[:s_quality] if options[:s_quality]
  ep.no_sound     = options[:no_sound]  if options[:no_sound]
  ep.no_cursor    = options[:no_cursor] if options[:no_cursor]
  ep.follow_mouse = options[:follow_mouse] if options[:follow_mouse]
  ep.width        = options[:width]  if options[:width]
  ep.height       = options[:height] if options[:height]
  ep.start!
end
