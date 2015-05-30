#!/usr/bin/env ruby
# village.rb
# Author: Andy Bettisworth
# Created At: 2015 0424 221430
# Modified At: 2015 0424 221430
# Description: sync external media from the Village

require 'optparse'
require 'fileutils'

module Village
  class Media
    attr_accessor :scope
    attr_accessor :local_dir
    attr_accessor :remote_dir

    def initialize
      @scope      = 'syncing all media...'
      @local_dir  = "#{ENV['HOME']}"
      @remote_dir = "/media/#{ ENV['USER'] }/Village"
    end

    def sync
      puts @scope
      require_dir(@local_dir)
      require_dir(@remote_dir)
      diff = dir_difference
      sync_file_diff(diff)
    end

    def require_dir(pathname)
      unless File.exist?(pathname)
        raise "MissingDirectoryError::#{pathname}"
      end
    end

    def dir_difference
      local_files  = get_local_files
      remote_files = get_remote_files

      local_files.each do |file, path|
        if remote_files.has_key?(file)
          remote_files.delete(file)
        end
      end

      remote_files
    end

    def get_local_files(target=@local_dir)
      local_files = Dir[target + "/**/*"]
      local_files.delete_if { |path| File.directory?(path) }
      local_files.map! { |path| [File.basename(path), path] }
      local_files = local_files.to_h
      local_files
    end

    def get_remote_files(target=@remote_dir)
      remote_files = Dir[target + "/**/*"]
      remote_files.delete_if { |path| File.directory?(path) }
      remote_files.map! { |path| [File.basename(path), path] }
      remote_files = remote_files.to_h
      remote_files
    end

    def sync_file_diff(diff, target=@local_dir, source=@remote_dir)
      diff.each do |filename, remote_path|
        target_path = File.dirname(remote_path).gsub(/^#{source}/, target)
        find_or_create_directory(target_path)
        puts "  #{target_path}/#{filename}"
        FileUtils.cp(remote_path, target_path)
      end
    end

    def find_or_create_directory(pathname)
      FileUtils.mkdir_p(pathname)
    end
  end

  class Documents < Village::Media
    def initialize
      @scope = 'syncing documents...'
      @local_dir  = "#{ENV['HOME']}/Documents"
      @remote_dir = "/media/#{ ENV['USER'] }/Village/Documents"
    end

    def sync
      super
    end
  end

  class Music < Village::Media
    def initialize
      @scope = 'syncing music...'
      @local_dir  = "#{ENV['HOME']}/Music"
      @remote_dir = "/media/#{ ENV['USER'] }/Village/Music"
    end

    def sync
      super
    end
  end

  class Pictures < Village::Media
    def initialize
      @scope = 'syncing pictures...'
      @local_dir  = "#{ENV['HOME']}/Pictures"
      @remote_dir = "/media/#{ ENV['USER'] }/Village/Pictures"
    end

    def sync
      super
    end
  end

  class Videos < Village::Media
    def initialize
      @scope = 'syncing videos...'
      @local_dir  = "#{ENV['HOME']}/Videos"
      @remote_dir = "/media/#{ ENV['USER'] }/Village/Videos"
    end

    def sync
      super
    end
  end
end

if __FILE__ == $0
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
