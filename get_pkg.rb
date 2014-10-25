#!/usr/bin/ruby -w
# get_pkg.rb
# Author: Andy Bettisworth
# Description: Get Ubuntu Packages

require 'nokogiri'
require 'open-uri'
require 'fileutils'

class GetPkg
  VERSION    = 'trusty'
  REPOSITORY = "packages.ubuntu.com/#{VERSION}"

  attr_accessor :buckets

  def get
    get_buckets
    download_packages
  end

  def get_buckets
    @buckets = Dir.entries('.').select! { |x| /dependency_bucket/.match(x) }
    @buckets.sort! { |x,y| /\d.*$/.match(x)[0].to_i <=> /\d.*$/.match(y)[0].to_i }
    @buckets.reverse!
  end

  def download_packages
    @buckets.each do |file|
      next if file == '.' || file == '..' || file == 'get_pkg.rb'

      FileUtils.mkdir_p("dir_#{file}") unless Dir.exist?("dir_#{file}")
      Dir.chdir("dir_#{file}")

      all_packages = File.new("../#{file}").readlines if File.exist?("../#{file}")
      all_packages.each do |pkg|
        url = "http://#{REPOSITORY}/i386/#{pkg.chomp}/download"
        doc = Nokogiri::HTML(open(url))
        url_node = doc.css('ul li a').first

        if url_node
          target_url = url_node['href']
          `wget #{target_url}`
          sleep(2)
        end
      end

      Dir.chdir('../')
    end
  end
end

if __FILE__ == $0
  cmd = GetPkg.new
  cmd.get
end
