  #!/usr/bin/env ruby
  # screencast.rb
  # Author: Andy Bettisworth
  # Created At: 2015 0521 182728
  # Modified At: 2015 0521 182728
  # Description: Record a window as a PNG and JSON metadata

module Admin
  module Window
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
  # > accept window IDs and String-based querys for best-fit
  # > if no window is specified, use the entire Desktop
  # > if no time is specified, run until CTRL^D exited process
  # > if no outpath given, default output to the Desktop
  # > output <name>_anim.js and <name>_packed.png
  # > end_frame_pause, how long to way for before loop (4000)
  # > simplification_tolerance, how many pixels able to waste in crush (512)
end
