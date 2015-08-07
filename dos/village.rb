#!/usr/bin/env ruby
# village.rb
# Author: Andy Bettisworth
# Created At: 2015 0424 221430
# Modified At: 2015 0424 221430
# Description: sync external media from the Village

require_relative 'admin'

module Admin
  class Village
    HOME = ENV['HOME']
    REMOTE = "/media/#{ ENV['USER'] }/Village"
    HOME_MEDIA = {
      documents: "#{ HOME }/Documents",
      downloads: "#{ HOME }/Downloads",
      music: "#{ HOME }/Music",
      pictures: "#{ HOME }/Pictures",
      videos: "#{ HOME }/Videos"
    }
    REMOTE_MEDIA = {
      documents: "#{ REMOTE }/Documents",
      downloads: "#{ REMOTE }/Downloads",
      music: "#{ REMOTE }/Music",
      pictures: "#{ REMOTE }/Pictures",
      videos: "#{ REMOTE }/Videos"
    }

    def download(media)
      require_dir(HOME_MEDIA[media])
      require_dir(REMOTE_MEDIA[media])
      diff = dir_diff(REMOTE_MEDIA[media], HOME_MEDIA[media])
      puts "Downloading #{ diff.count } files from #{ REMOTE_MEDIA[media] } to #{ HOME_MEDIA[media] }..."
      sync_diff(diff, HOME_MEDIA[media], REMOTE_MEDIA[media])
    end

    def upload(media)
      require_dir(HOME_MEDIA[media])
      require_dir(REMOTE_MEDIA[media])
      diff = dir_diff(HOME_MEDIA[media], REMOTE_MEDIA[media])
      puts "Uploading #{ diff.count } files from #{ HOME_MEDIA[media] } to #{ REMOTE_MEDIA[media] }..."
      sync_diff(diff, REMOTE_MEDIA[media], HOME_MEDIA[media])
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'Usage: village [options]'

    opts.on('--download MEDIA',
            [:documents, :downloads, :music, :pictures, :videos],
            'Download media (documents, downloads, music, pictures, videos)') do |media|
      options[:download] = media
    end

    opts.on('--upload MEDIA',
            [:documents, :downloads, :music, :pictures, :videos],
            'Upload media (documents, downloads, music, pictures, videos)') do |media|
      options[:upload] = media
    end
  end
  option_parser.parse!

  village = Village.new

  if options[:download]
    village.download(options[:download])
  elsif options[:upload]
    village.upload(options[:upload])
  else
    puts option_parser
    exit 1
  end
end
