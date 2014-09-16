#!/usr/bin/ruby -w
# generate_md5sum.rb
# Author: Andy Bettisworth
# Description: Generate md5sums

class GenerateMD5Sum
  DESKTOP = "#{ENV['HOME']}/Desktop"

  def generate
    Dir["**"].each do |file|
      `md5sum #{file} > #{file}.md5`
    end
  end
end

## > optparse dir_in and dir_out
## > handle dir or file
md5_gen = GenerateMD5Sum.new
md5_gen.generate
