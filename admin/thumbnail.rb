#!/usr/bin/env ruby -w
# thumbnail.rb
# Author: Andy Bettisworth and RMagick Project
# Description: Generate a thumbnail of a larger image
# https://github.com/rmagick/rmagick

require 'rmagick'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Admin
  module Magick
    class Thumbnail
      DEFAULT_SIZE = 120

      def initialize(file_path, size = DEFAULT_SIZE)
        exit 1 unless File.exist?(file_path)

        @filename   = File.basename(file_path)
        @geometry   = get_geometry(size)
        @image      = get_image(@filename, @geometry)
        @background = get_background(size)
        @thumbnail  = composite_images(@image, @background)
      end

      def get_geometry(size = DEFAULT_SIZE)
        puts 'Getting geometry...'
        geom = "#{size.to_i}x#{size.to_i}"
        geom
      end

      def get_image(filename, geometry)
        puts 'Getting image...'
        image = Magick::Image.read(filename)[0]
        image.change_geometry!(geometry) { |cols, rows| image.thumbnail! cols, rows }
        image
      end

      def get_background(size = DEFAULT_SIZE)
        puts 'Getting background...'
        frame = Magick::Image.new(size.to_i+6, size.to_i+6) { self.background_color = 'gray75' }
        frame = frame.raise(3,3)

        background = Magick::Image.new(size.to_i+50, size.to_i+50) {self.background_color = 'white'}
        background = background.composite(frame, Magick::CenterGravity, Magick::OverCompositeOp)
        background
      end

      def composite_images(image, background)
        puts 'Compositing images...'
        thumbnail = background.composite(image, Magick::CenterGravity, Magick::OverCompositeOp)
        thumbnail
      end

      def save
        puts 'Saving image...'
        @thumbnail.write("#{File.basename(@filename)}_thumbnail.gif")
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin

  if ARGV[0] && ARGV[1]
    thumbnail = Magick::Thumbnail.new(ARGV[0], ARGV[1])
    thumbnail.save
  else
    puts 'Usage: ruby thumbnail FILENAME SIZE'
    exit 1
  end
end
