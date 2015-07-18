#!/usr/bin/env ruby -w
# pomodoro.rb
# Author: Andy Bettisworth
# Description: Rotate the Desktop's wallpaper every minute for the next 20 minutes

require_relative 'project'

module Project
  # rotate background every minute for twenty minutes
  class Pomodoro
    BACKGROUND_DEFAULT = '/usr/share/backgrounds/warty-final-ubuntu.png'
    GSETTING = 'org.gnome.desktop.background'
    MINUTE   = 60

    attr_accessor :image_dir
    attr_accessor :images
    attr_reader :original_background

    def start(image_dir)
      if File.exist?(image_dir)
        @image_dir = image_dir
        @images    = Dir.entries(image_dir).reject { |x| x == '.' || x == '..' }
        @images.sort!
      else
        STDERR.puts "NoDirectoryError: no such directory '#{image_dir}'"
        exit 1
      end

      set_original_background

      20.times do
        rotate_background
        sleep(MINUTE)
      end

      reset_background
    end

    private

    def rotate_background
      current_image = File.basename(get_current_background)
      index = @images.find_index(current_image)

      if index.nil?
        next_image = "#{@image_dir}/#{@images.first}"
      else
        next_image = "#{@image_dir}/#{@images.at(index + 1)}"
      end

      set_background(next_image)
    end

    def reset_background
      set_background(BACKGROUND_DEFAULT)
    end

    def get_current_background
      image_path = `gsettings get #{GSETTING} picture-uri`
      image_path = image_path.gsub('file://', '')
      image_path = image_path.strip.gsub("'", '')
      image_path
    end

    def set_original_background
      @original_background = get_current_background
      current_background = File.basename(@original_background)
      current_background
    end

    def set_background(image_path)
      `GNOME_SESSION_PID=$(pgrep gnome-session); export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$GNOME_SESSION_PID/environ|cut -d= -f2-); DISPLAY=:0 gsettings set #{GSETTING} picture-uri "file://#{image_path}"`
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Project

  image_dir = ARGV[0] if ARGV.count > 0
  image_dir ||= "#{ENV['HOME']}/Pictures/Pomodoro"
  mgr = Pomodoro.new
  mgr.start(image_dir)
end
