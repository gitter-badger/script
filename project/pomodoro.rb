#!/usr/bin/env ruby -w
# pomodoro.rb
# Author: Andy Bettisworth
# Description: Rotate the Desktop's wallpaper for the next 20 minutes

class Pomodoro
  def start(image_dir)
    puts image_dir
    puts File.exist?(image_dir)
  end

  private

  def disable_network
  end

  def swap_wallpaper
  end
end

if __FILE__ == $0
  image_dir = ARGV[0] if ARGV.count > 0
  image_dir ||= "#{ENV['HOME']}/Pictures/Backgrounds"
  mgr = Pomodoro.new
  mgr.start(image_dir)
end
