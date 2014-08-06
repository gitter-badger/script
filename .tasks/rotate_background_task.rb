#!/usr/bin/ruby -w
# rotate_background_task.rb
# Author: Andy Bettisworth
# Description: Rotate Desktop background image using locally stored images

class DesktopBackground
  GSETTING = "org.gnome.desktop.background"

  attr_accessor :image_directory
  attr_reader :current_background

  def rotate
    dir_exists  = Dir.exist?(@image_directory)
    entries     = Dir.entries(@image_directory).reject {|x| x == '.' || x == '..'}
    entry_count = entries.length

    if dir_exists && entry_count > 0
      get_current_background
      @current_background ||= "desktop-background.jpg"

      current_background_index = entries.index(@current_background)
      rand = current_background_index

      until rand != current_background_index
        rand = Random.rand(1..entry_count - 1)
      end
      new_pic = entries[rand]

      system "DISPLAY=:0 gsettings set #{GSETTING} picture-uri file://'#{@image_directory}/#{new_pic}'"

    elsif Dir.exist?(@image_directory) == false
      raise "ImageDirectoryRequiredError: set @image_directory before rotating the background."
    elsif entry_count < 1
      raise "ImageDirectoryEmptyError: no images found within target @image_directory."
    else
      raise "UnknownError: I have no clue what went wrong, you?"
    end
  end

  def get_current_background
    current_background_path  = `gsettings get #{GSETTING} picture-uri`.gsub('file://','')
    current_background       = File.basename(current_background_path.strip.gsub("'", ''))
    @current_background = current_background
    current_background
  end
end
