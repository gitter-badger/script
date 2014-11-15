#!/usr/bin/ruby -w
# img_to_pdf.rb
# Author: Andy Bettisworth
# Description: Creates a PDF from images within target Dir

require 'prawn'
require 'optparse'

class IMGToPDF
  def generate_pdf_from_img(image_dir, pdf_filename)
    all_images = Dir.entries(image_dir)
    all_images.delete('..')
    all_images.delete('.')
    all_images.sort!

    Prawn::Document.generate("#{pdf_filename}.pdf") do
      all_images.each do |image|
        image "#{image_dir}/#{image}", position: :center, vposition: :center, width: 600
      end
    end
  end
end

if __FILE__ == $0
  options = {}
  OptionParser.new do |opts|
    opts.banner = "USAGE: img_to_pdf --img rails_init_guide/ --pdf rails_initialization.pdf"

    opts.on("--img [DIR]", 'Set path to image directory') do |target_img_dir|
      options[:image_dir] = File.expand_path(target_img_dir.to_s)
    end

    opts.on("--pdf [PATH]", 'Set PDF filename') do |pdf_filename|
      options[:pdf_filename] = pdf_filename.to_s
    end
  end.parse!

  if options[:image_dir]
    if options[:pdf_filename]
      converter = IMGToPDF.new
      converter.generate_pdf_from_img(options[:image_dir], options[:pdf_filename])
    else
      puts '!ERROR: A PDF filename is required. (--pdf)'
    end
  else
    puts '!ERROR: An image directory is required. (--img)'
  end
end
