#!/usr/bin/env ruby
# media.rb
# Author: Andy Bettisworth
# Created At: 2015 0530 103908
# Modified At: 2015 0530 103908
# Description: alias to village.rb script

require_relative 'village'
require_relative 'admin'

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: village [options]'

    opts.on('--documents', 'Sync Documents from neighboring Village') do
      options[:documents] = true
    end

    opts.on('--music', 'Sync Music from neighboring Village') do
      options[:music] = true
    end

    opts.on('--pictures', 'Sync Pictures from neighboring Village') do
      options[:pictures] = true
    end

    opts.on('--videos', 'Sync Videos from neighboring Village') do
      options[:videos] = true
    end
  end
  option_parser.parse!

  if options.empty?
    puts option_parser
    exit 1
  end

  if options[:documents]
    documents = Village::Documents.new
    documents.sync
  end

  if options[:music]
    music = Village::Music.new
    music.sync
  end

  if options[:pictures]
    pictures = Village::Pictures.new
    pictures.sync
  end

  if options[:videos]
    videos = Village::Videos.new
    videos.sync
  end
end
