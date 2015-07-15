#!/usr/bin/env ruby
# yamlize.rb
# Author: Andy Bettisworth
# Created At: 2015 0128 205647
# Modified At: 2015 0128 205647
# Description: generate yaml file from rails seed (activerecords)

require 'active_record'
require 'yaml'
require 'logger'

class Yamlizer
  def generate(seed_path, filename='seed.yml')
    raise 'NoFileError' unless File.exist?(seed_path)
  end

  private

  def ensure_extname(filename)
    unless File.extname(filename) == '.yml'
      filename = File.basename(filename, File.extname(filename))
      filename += '.yml'
    end
    filename
  end
end

if __FILE__ == $0
  ctrl = Yamlizer.new

  if ARGV.count == 2
    ctrl.generate(ARGV[0], ARGV[1])
  elsif ARGV.count == 1
    ctrl.generate(ARGV[0])
  else
    STDOUT.puts 'USAGE: yamlizer SEED FILENAME'
  end
end