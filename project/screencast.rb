#!/usr/bin/env ruby
# screencast.rb
# Author: Andy Bettisworth
# Created At: 2015 0521 182728
# Modified At: 2015 0521 182728
# Description: Record a window as a PNG and JSON metadata

require 'optparse'

module Admin
  module WindowManager
    class Screencast
      def capture
        # > save screenshot
      end

      def encode
        # > create packed png
        # > create timeline
      end
    end
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = "Usage: screencast [options]"

    opts.on('-w', '--window WINDOW', 'Target specific window.') do |regexp|
      options[:window] = regexp
    end

    opts.on('-t', '--timeout MINUTES', 'Timeout after N minutes.') do |minutes|
      options[:timeout] = minutes
    end

    opts.on('-d', '--delay SECONDS', 'Set delay before looping animation.') do |seconds|
      options[:delay] = seconds
    end

    opts.on('-o', '--output NAME', 'Give output files a name.') do |name|
      options[:output] = name
    end
  end
  option_parser.parse!

  puts option_parser

  # > default is start recording entire desktop until process is killed output to desktop
  # > accept window IDs and String-based querys for best-fit
  # > output <name>_anim.js and <name>_packed.png
  # > end_frame_pause delay, how long to way for before loop (4000)
  # > simplification_tolerance, how many pixels able to waste in crush (512)
end
