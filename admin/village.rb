#!/usr/bin/env ruby
# village.rb
# Author: Andy Bettisworth
# Created At: 2015 0424 221430
# Modified At: 2015 0424 221430
# Description: sync with external media from the Village

require 'optparse'
require 'fileutils'

module Village
  class Media
    def sync
      puts "syncing all media..."
      # require_local_music
      # require_remote_music
      # diff = music_dir_difference
      # pull_remote_music(diff)
    end

    # def require_local_music
    #   exit 1 unless File.exist?(LOCAL_MUSIC)
    # end

    # def require_remote_music
    #   exit 2 unless File.exist?(REMOTE_MUSIC)
    # end

    # def music_dir_difference
    #   local_music  = get_local_music
    #   remote_music = get_remote_music

    #   local_music.each do |file, path|
    #     if remote_music.has_key?(file)
    #       remote_music.delete(file)
    #     end
    #   end

    #   remote_music
    # end

    # def get_local_dir(target)
    #   local_music = Dir[LOCAL_MUSIC + "/**/*"]
    #   local_music.delete_if { |path| File.directory?(path) }
    #   local_music.map! { |path| [File.basename(path), path] }
    #   local_music = local_music.to_h
    #   local_music
    # end

    # def get_remote_dir(target)
    #   remote_music = Dir[REMOTE_MUSIC + "/**/*"]
    #   remote_music.delete_if { |path| File.directory?(path) }
    #   remote_music.map! { |path| [File.basename(path), path] }
    #   remote_music = remote_music.to_h
    #   remote_music
    # end

    # def pull_remote_dir(diff, dir)
    #   diff.each do |file, path|
    #     source_path = path
    #     target_path = File.dirname(path).gsub(/.*?Music/, LOCAL_MUSIC)
    #     require_directory(target_path)
    #     puts "#{target_path}/#{File.basename(source_path)}"
    #     FileUtils.cp(source_path, target_path)
    #   end
    # end

    # def require_directory(dir)
    #   FileUtils.mkdir_p(dir)
    # end
  end

  class Documents < Village::Media
    LOCAL_DIR  = "#{ENV['HOME']}/Documents"
    REMOTE_DIR = "/media/#{ ENV['USER'] }/Village/Documents"

    def sync
      puts 'syncing documents...'
    end
  end

  class Music < Village::Media
    LOCAL_DIR  = "#{ENV['HOME']}/Music"
    REMOTE_DIR = "/media/#{ ENV['USER'] }/Village/Music"

    def sync
      puts 'syncing music...'
    end
  end

  class Pictures < Village::Media
    LOCAL_DIR  = "#{ENV['HOME']}/Pictures"
    REMOTE_DIR = "/media/#{ ENV['USER'] }/Village/Pictures"

    def sync
      puts 'syncing pictures...'
    end
  end

  class Videos < Village::Media
    LOCAL_DIR  = "#{ENV['HOME']}/Videos"
    REMOTE_DIR = "/media/#{ ENV['USER'] }/Village/Videos"

    def sync
      puts 'syncing videos...'
    end
  end
end

if __FILE__ == $0
  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: village [options]'

    opts.on('--all', 'Sync all media from neighboring Village') do
      options[:all] = true
    end

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
  end

  if options[:all]
    media = Village::Media.new
    media.sync
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

  exit
end
