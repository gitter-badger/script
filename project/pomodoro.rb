#!/usr/bin/env ruby -w
# pomodoro.rb
# Author: Andy Bettisworth
# Description: Rotate the Desktop's wallpaper for the next 20 minutes

class Pomodoro
  GSETTING = "org.gnome.desktop.background"

  attr_accessor :image_dir
  attr_accessor :images

  def start(image_dir)
    if File.exist?(image_dir)
      @image_dir = image_dir
      @images    = Dir.entries(image_dir).reject {|x| x == '.' || x == '..'}
    else
      STDERR.puts "NoDirectoryError: no such directory '#{image_dir}'"
      exit 1
    end

    puts get_current_background
    # rotate_wallpaper
  end

  private

  def get_current_background
    current_background_path = `gsettings get #{GSETTING} picture-uri`.gsub('file://','')
    current_background = File.basename(current_background_path.strip.gsub("'", ''))
    current_background
  end

  def disable_network
  end

  def rotate_wallpaper
  end
end

if __FILE__ == $0
  image_dir = ARGV[0] if ARGV.count > 0
  image_dir ||= "#{ENV['HOME']}/Pictures/Backgrounds"
  mgr = Pomodoro.new
  mgr.start(image_dir)
end
