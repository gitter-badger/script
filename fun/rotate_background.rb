#!/usr/bin/ruby -w
# rotate_background.rb
# Author: Andy Bettisworth
# Description: Rotate Desktop background image using locally stored images

class DesktopBackground
  GSETTING = "org.gnome.desktop.background"

  attr_accessor :images
  attr_reader :current_background

  def rotate
    exit_if_no_images

    entries = Dir.entries(@images).reject {|x| x == '.' || x == '..'}

    if entries.length > 0
      get_current_background
      @current_background ||= "desktop-background.jpg"

      current_background_index = entries.index(@current_background)
      rand = current_background_index

      until rand != current_background_index
        rand = Random.rand(1..entry_count - 1)
      end
      new_pic = entries[rand]

      set_background("#{@images}/#{new_pic}")
    else
      raise "UnknownError: I have no clue what went wrong, you?"
    end
  end

  def get_current_background
    current_background_path = `gsettings get #{GSETTING} picture-uri`.gsub('file://','')
    @current_background     = File.basename(current_background_path.strip.gsub("'", ''))
    @current_background
  end

  def set_background(image_pathname)
    `GNOME_SESSION_PID=$(pgrep gnome-session); export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$GNOME_SESSION_PID/environ|cut -d= -f2-); DISPLAY=:0 gsettings set #{GSETTING} picture-uri "file://#{image_pathname}"`
  end

  private

  def exit_if_no_images
    if Dir.exist?(@images) == false
      raise "No directory found at '#{@images}'"
    end

    entries = Dir.entries(@images).reject {|x| x == '.' || x == '..'}
    if entries.length < 1
      raise "No images found in '#{@images}'"
    end
  end
end

if __FILE__ == $0
  b = DesktopBackground.new
  b.images = "#{ENV['HOME']}/Pictures/Backgrounds"
  b.rotate
end
