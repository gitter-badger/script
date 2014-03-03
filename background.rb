#!/usr/bin/ruby -w
# background.rb
# Author: Andy Bettisworth
# Description: Rotate desktop background

class RotateBackground
  def next
    current_pic = `gsettings get org.gnome.desktop.background picture-uri`
    current_pic = /(Backgrounds)\/(\w.*)/.match(current_pic)
    if current_pic.class == NilClass
      new_pic = "desktop-background.jpg"
    else
      current_pic = current_pic[2]
      current_pic.gsub!("'", '')
      new_pic = current_pic
    end
    all_pics = Dir.entries("#{ENV['HOME']}/Pictures/Backgrounds").reject { |x| x=='.' || x=='..' }
    while current_pic == new_pic
      random_number = Random.rand(1..all_pics.length)
      new_pic = all_pics[random_number]
    end
    system("gsettings set org.gnome.desktop.background picture-uri 'file:///home/wurde/Pictures/Backgrounds/#{new_pic}'")
  end
end

spinster = RotateBackground.new
spinster.next
