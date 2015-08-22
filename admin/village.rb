#!/usr/bin/env ruby
# village.rb
# Author: Andy Bettisworth
# Created At: 2015 0424 221430
# Modified At: 2015 0424 221430
# Description: sync external media from the Village

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Admin
  # sync with external hard drive
  class Village
    HOME_MEDIA = {
      documents: File.join(HOME, 'Documents'),
      downloads: File.join(HOME, 'Downloads'),
      music: File.join(HOME, 'Music'),
      pictures: File.join(HOME, 'Pictures'),
      videos: File.join(HOME, 'Videos')
    }
    attr_accessor :remote_media

    def initialize
      @is_windows = (ENV['OS'] == 'Windows_NT')

      if @is_windows
        disk_out = `wmic logicaldisk get caption,description,filesystem`
        disk = disk_out.split(/^/).keep_if { |e| e.length > 3}.collect { |e| e.squeeze }.last.chop.chop
        if /NTFS/.match(disk)
          remote = disk[0..1]
        else
          STDERR.puts "ERROR: Missing external drive"
          exit 1
        end
      else
        remote = File.join('media', ENV['USER'], 'Village')
      end

      @remote_media = {
        documents: File.join(remote, 'Documents'),
        downloads: File.join(remote, 'Downloads'),
        music: File.join(remote, 'Music'),
        pictures: File.join(remote, 'Pictures'),
        videos: File.join(remote, 'Videos')
      }
    end

    def download(media)
      require_dir(HOME_MEDIA[media])
      require_dir(@remote_media[media])
      diff = dir_diff(@remote_media[media], HOME_MEDIA[media])
      puts "Downloading #{ diff.count } files from #{ @remote_media[media] } to #{ HOME_MEDIA[media] }..."
      sync_diff(diff, HOME_MEDIA[media], @remote_media[media])
    end

    def upload(media)
      require_dir(HOME_MEDIA[media])
      require_dir(@remote_media[media])
      diff = dir_diff(HOME_MEDIA[media], @remote_media[media])
      puts "Uploading #{ diff.count } files from #{ HOME_MEDIA[media] } to #{ @remote_media[media] }..."
      sync_diff(diff, @remote_media[media], HOME_MEDIA[media])
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
