#!/usr/bin/ruby -w
# background_task.rb
# Author: Andy Bettisworth
# Description: Rotate desktop background

class Background
  GSETTING          = "org.gnome.desktop.background"
  BACKGROUND_IMAGES = "file:///home/wurde/Pictures/Backgrounds"

  def self.rotate
    current_background_path = `gsettings get #{GSETTING} picture-uri`.gsub('file://','')
    current_background      = File.basename(current_background_path.strip.gsub("'", ''))
    current_background    ||= "desktop-background.jpg"

    all_pictures             = Dir.entries("/home/wurde/Pictures/Backgrounds").reject { |x| x == '.' || x == '..' }
    current_background_index = all_pictures.index(current_background)

    rand = current_background_index
    until rand != current_background_index
      rand = Random.rand(1..all_pictures.length-1)
    end
    new_pic = all_pictures[rand]

    system "DISPLAY=:0 gsettings set #{GSETTING} picture-uri '#{BACKGROUND_IMAGES}/#{new_pic}'"
  end
end

## Usage
# Background.rotate

# describe RotateBackground do
#   describe "#rotate" do
#     it "should "
#   end
# end
