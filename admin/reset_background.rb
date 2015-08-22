#!/usr/bin/env ruby
# reset_background.rb
# Author: Andy Bettisworth
# Created At: 2015 0109 001429
# Modified At: 2015 0109 001429
# Description: To reset Background to the default ubuntu wallpaper

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Admin
  # reset background to default
  class ResetBackground
    GSETTING = 'org.gnome.desktop.background'

    def set_background(image_path)
      if File.exist?(image_path)
        `GNOME_SESSION_PID=$(pgrep gnome-session); export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$GNOME_SESSION_PID/environ|cut -d= -f2-); DISPLAY=:0 gsettings set #{GSETTING} picture-uri "file://#{image_path}"`
      else
        STDERR.puts "NoImageError: no such error at '#{image_path}'"
        exit 1
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  inlude Admin

  image_dir = ARGV[0] if ARGV.count > 0
  image_dir ||= '/usr/share/backgrounds/warty-final-ubuntu.png'
  mgr = ResetBackground.new
  mgr.set_background(image_dir)
end
