#!/usr/bin/env ruby
# screencast.rb
# Author: Andy Bettisworth
# Created At: 2015 0521 182728
# Modified At: 2015 0521 182728
# Description: Record a window as a PNG and JSON metadata

# > allow conversion into MP4 format AAC-LC (audio), H.264 (video)
# ffmpeg -i morsecode_led.ogv -strict experimental -vcodec libx264 morsecode_led.mp4

require 'optparse'
require 'fileutils'

require_relative 'wm'

module Admin
  module WindowManager
    class Screencast
      attr_accessor :pid
      attr_accessor :delay
      attr_accessor :timeout
      attr_accessor :no_sound
      attr_accessor :mic_audio
      attr_accessor :sys_audio

      def require_libav
        `which avconv`
        unless $? == 0
          raise StandardError, 'The libav-tools must be installed.'
        end
      end

      def start!
        require_libav

        puts "Starting Capture"
        puts "================"

        Signal.trap("INT") do
          puts
          puts "================"
          puts "Stopping Capture"
          Process.kill("INT", @pid)
        end

        @resolution = get_resolution
        @mic_audio  = get_mic_audio
        @sys_audio  = get_sys_audio

        cmd  = build_command
        # @pid = spawn(cmd)
        # Process.wait @pid
      end

      private

      def get_resolution
        `xrandr 2>/dev/null | grep current | sed 's/.*current //;s/,.*//;s/ x /x/'`
      end

      def get_mic_audio
        `pactl list | grep alsa_input | awk '{print $2}' | tail -n1`
      end

      def get_sys_audio
        `pactl list | grep -A2 '^Source #' | grep 'Name: .*\.monitor$' | awk '{print $NF}' | tail -n1`
      end

      def build_command
        cmd  = ""
        cmd += " sleep #{@delay};" if @delay
        cmd += " timeout #{@timeout}" if @timeout
        cmd += " avconv -f x11grab -s #{@resolution.strip} -r 30 -i :0.0"
        if @mic_audio
          cmd += " -f pulse -i #{@mic_audio}"
        elsif @sys_audio
          cmd += " -f pulse -i #{@sys_audio}"
        elsif @no_sound
        else
          cmd += " -f pulse -i #{@sys_audio.strip} -f pulse -i #{@mic_audio.strip}"
          cmd += " -filter_complex amix=inputs=2:duration=first:dropout_transition=3"
        end
        cmd += " -qscale 5"
        cmd += " -vcodec libx264"
        cmd += " -acodec libmp3lame"
        cmd += " -y screencast_#{ENV['HOSTNAME']}_#{Time.now.strftime('%Y%m%d%H%M')}.mp4"
        puts cmd

      end
    end
  end
end

if __FILE__ == $0
  include Admin::WindowManager

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: screencast [options]"

    opts.on('-d', '--delay TIME', 'Delay start for N seconds.') do |time|
      options[:delay] = time
    end

    opts.on('-t', '--timeout TIME', 'Timeout after N minutes.') do |time|
      options[:timeout] = time
    end

    opts.on('--no-sound', 'Do not record audio.') do
      options[:no_sound] = true
    end

    opts.on('--mike-audio', 'Only record microphone audio.') do
      options[:mic_audio] = true
    end

    opts.on('--sys-audio', 'Only record system audio.') do
      options[:sys_audio] = true
    end
  end
  option_parser.parse!

  ep           = Screencast.new
  ep.delay     = options[:delay]      if options[:delay]
  ep.timeout   = options[:timeout]    if options[:timeout]
  ep.no_sound  = options[:no_sound]   if options[:no_sound]
  ep.mic_audio = options[:mic_audio]  if options[:mic_audio]
  ep.sys_audio = options[:sys_audio]  if options[:sys_audio]
  ep.start!
end
