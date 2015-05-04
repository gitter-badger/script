#!/usr/bin/env ruby -w
# img_describe.rb
# Author: RMagick Project
# Description: Get metadata of an image
# https://github.com/rmagick/rmagick

require 'rmagick'

class Magick::Image
  def self.describe(image_path)
    exit 1 unless File.exist?(image_path)

    puts "Describing #{image_path}..."
    img = Magick::Image.read(image_path).first

    image = {
      format:     img.format,
      class_type: img.class_type,
      depth:      img.depth,
      colors:     img.number_colors,
      filesize:   img.filesize,
      geometry:   [img.columns, img.rows],
      resolution: [img.x_resolution.to_i, img.y_resolution.to_i],
      units:      img.units
    }
    if img.properties.length > 0
      image[:properties] = []
      img.properties do |name, value|
        image[:properties] << [name, value]
      end
    end

    puts "   Format: #{image[:format]}"
    puts "   Geometry: #{image[:columns]}x#{image[:rows]}"
    puts "   Class: " + case image[:class_type]
                        when Magick::DirectClass
                          'DirectClass'
                        when Magick::PseudoClass
                          'PseudoClass'
                        end
    puts "   Depth: #{image[:depth]} bits-per-pixel"
    puts "   Colors: #{image[:number_colors]}"
    puts "   Filesize: #{image[:filesize]}"
    puts "   Resolution: #{image[:x_resolution]}x#{image[:y_resolution]} "\
         "pixels/#{image[:units] == Magick::PixelsPerInchResolution ?
         'inch' : 'centimeter'}"

    if image[:properties].length > 0
      puts '   Properties:'
      image[:properties].each do |name, value|
        puts %Q{      #{name} = "#{value}"}
      end
    end

    image
  end
end

if __FILE__ == $0
  if ARGV.length == 0
    puts 'Usage: img_describe FILENAME...'
    puts 'Specify one or more image filenames as arguments.'
    exit
  end

  ARGV.each do |file|
    Magick::Image.describe(file)
  end
end
