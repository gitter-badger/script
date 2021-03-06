#!/usr/bin/env ruby
# screencast.rb
# Author: Andy Bettisworth
# Created At: 2015 0521 182728
# Modified At: 2015 0521 182728
# Description: Record a window as a PNG and JSON metadata

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'
require 'admin/wm'

module Admin
  module WindowManager
    # save screen as video
    class Screencast
      attr_accessor :pid
      attr_accessor :sleep
      attr_accessor :timeout
      attr_accessor :no_sound
      attr_accessor :mic_audio
      attr_accessor :sys_audio

      def require_libav
        `which avconv`
        fail StandardError, 'Install libav-tools.' unless $CHILD_STATUS == 0
      end

      def start!
        require_libav

        @resolution = get_resolution
        @mic_audio  = get_mic_audio
        @sys_audio  = get_sys_audio

        cmd  = build_command
        `#{cmd}`
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
        cmd += " sleep #{@sleep};" if @sleep
        cmd += " timeout #{@timeout}" if @timeout
        cmd += " avconv -f x11grab -s #{@resolution.strip} -r 30 -i :0.0"
        unless @no_sound
          cmd += " -f pulse -i #{@sys_audio.strip} -f pulse -i #{@mic_audio.strip}"
          cmd += " -filter_complex amix=inputs=2:duration=first:dropout_transition=3"
        end
        cmd += " -qscale 4"
        cmd += " -vcodec libx264"
        cmd += " -acodec libmp3lame"
        cmd += " -crf 0"
        cmd += " -threads auto"
        cmd += " -y screencast_#{Time.now.strftime('%Y%m%d%H%M')}.mp4"
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
    opts.banner = 'Usage: screencast [options]'

    opts.on('-s', '--sleep TIME', 'Delay start for N seconds.') do |time|
      options[:sleep] = time
    end

    opts.on('-t', '--timeout TIME', 'Timeout after N minutes.') do |time|
      options[:timeout] = time
    end

    opts.on('--no-sound', 'Do not record audio.') do
      options[:no_sound] = true
    end
  end
  option_parser.parse!

  ep          = Screencast.new
  ep.sleep    = options[:sleep]    if options[:sleep]
  ep.timeout  = options[:timeout]  if options[:timeout]
  ep.no_sound = options[:no_sound] if options[:no_sound]
  ep.start!
end
