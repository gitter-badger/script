#!/usr/bin/env ruby
# music.rb
# Author: Andy Bettisworth
# Created At: 2015 0404 162213
# Modified At: 2015 0404 162213
# Description: sync local and external music collection

require 'fileutils'

class DirMusic
  LOCAL_MUSIC  = ENV['HOME'] + '/Music'
  REMOTE_MUSIC = "/media/#{ ENV['USER'] }/Village/Music"

  def sync
    require_local_music
    require_remote_music
    diff = music_dir_difference
    pull_remote_music(diff)
  end

  def require_local_music
    exit 1 unless File.exist?(LOCAL_MUSIC)
  end

  def require_remote_music
    exit 2 unless File.exist?(REMOTE_MUSIC)
  end

  def music_dir_difference
    local_music  = get_local_music
    remote_music = get_remote_music

    local_music.each do |file, path|
      if remote_music.has_key?(file)
        remote_music.delete(file)
      end
    end

    remote_music
  end

  def get_local_music
    local_music = Dir[LOCAL_MUSIC + "/**/*"]
    local_music.map! { |path| [File.basename(path), path] }
    local_music = local_music.to_h
    local_music
  end

  def get_remote_music
    remote_music = Dir[REMOTE_MUSIC + "/**/*"]
    remote_music.map! { |path| [File.basename(path), path] }
    remote_music = remote_music.to_h
    remote_music
  end

  # > pull remote music to local dir
  def pull_remote_music(*diff)
    diff.flatten!

    diff.each do |path|
      puts path
      # FileUtils.mv(path, LOCAL_MUSIC)
    end
  end

  def make_dir(dir)
    FileUtils.mkdir_p(dir)
  end
end

if __FILE__ == $0
  music = DirMusic.new
  music.sync
end
