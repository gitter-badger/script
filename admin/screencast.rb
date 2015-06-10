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
      attr_accessor :pid
      attr_accessor :query
      attr_accessor :delay
      attr_accessor :timeout
      attr_accessor :v_quality
      attr_accessor :s_quality
      attr_accessor :no_sound
      attr_accessor :no_cursor
      attr_accessor :framerate
      attr_accessor :frequency
      attr_accessor :follow_mouse
      attr_accessor :width
      attr_accessor :height
      attr_accessor :outfile

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

        Signal.trap("INT") do
          puts
          puts "================"
          puts "Stopping Capture"
          Process.kill("INT", @pid)
        end

        cmd  = build_command
        @pid = spawn(cmd)
        Process.wait @pid
      end

      private

      def build_command
        cmd  = ""
        cmd += " sleep #{@delay};" if @delay
        cmd += " timeout #{@timeout}" if @timeout
        cmd += " recordmydesktop"
        cmd += " --quick-subsampling"
        cmd += " --pause-shortcut Control+p"
        if @query
          screen = window(@query)
          if screen[:id]
            cmd += " --windowid #{screen[:id]}"
          end
        end
        cmd += " --no-frame"
        cmd += " --overwrite"
        cmd += " --v_bitrate 8000000"
        if @v_quality
          if (0..63).include?(@v_quality)
            cmd += " --v_quality #{@v_quality}" if @v_quality.is_a? Integer
          end
        else
          cmd += " --v_quality 63"
        end
        if @s_quality
          if (-1..10).include?(@s_quality)
            cmd += " --s_quality #{@s_quality}" if @s_quality.is_a? Integer
          end
        else
          cmd += " --s_quality 10"
        end
        if @no_sound
          cmd += " --no-sound"
        end
        if @no_cursor
          cmd += " --no-cursor"
        end
        if @framerate
          cmd += " --fps #{@framerate}"
        else
          cmd += " --fps 30"
        end
        if @frequency
          cmd += " --freq #{@frequency}"
        else
          cmd += " --freq 40000"
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
        cmd += " -o #{@outfile}" if @outfile
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

    opts.on('-d', '--delay TIME', 'Delay screencast for N seconds.') do |time|
      options[:delay] = time
    end

    opts.on('-t', '--timeout TIME', 'Timeout after N minutes.') do |time|
      options[:timeout] = time
    end

    opts.on('--v-quality INTEGER', 'Video encoding quality (0..63).') do |integer|
      options[:v_quality] = integer
    end

    opts.on('--s-quality INTEGER', 'Audio encoding quality (-1..10).') do |integer|
      options[:s_quality] = integer
    end

    opts.on('--no-sound', 'Do not record audio.') do
      options[:no_sound] = true
    end

    opts.on('--no-cursor', 'Do not include cursor.') do
      options[:no_cursor] = true
    end

    opts.on('--fps', 'Adjust the video framerate.') do
      options[:framerate] = true
    end

    opts.on('--freq', 'Adjust the sound frequency.') do
      options[:frequency] = true
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

    opts.on('-o', '--outfile FILENAME', 'Name of recorded video.') do |string|
      options[:outfile] = string
    end
  end
  option_parser.parse!

  ep = Screencast.new
  ep.query        = options[:query]     if options[:query]
  ep.delay        = options[:delay]     if options[:delay]
  ep.timeout      = options[:timeout]   if options[:timeout]
  ep.v_quality    = options[:v_quality] if options[:v_quality]
  ep.s_quality    = options[:s_quality] if options[:s_quality]
  ep.no_sound     = options[:no_sound]  if options[:no_sound]
  ep.no_cursor    = options[:no_cursor] if options[:no_cursor]
  ep.framerate    = options[:framerate] if options[:framerate]
  ep.frequency    = options[:frequency] if options[:frequency]
  ep.follow_mouse = options[:follow_mouse] if options[:follow_mouse]
  ep.width        = options[:width]     if options[:width]
  ep.height       = options[:height]    if options[:height]
  ep.outfile      = options[:outfile]   if options[:outfile]
  ep.start!
end
