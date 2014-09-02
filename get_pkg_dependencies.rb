#!/usr/bin/ruby -w
# get_pkg_dependencies.rb
# Author: Andy Bettisworth
# Description: Get Ubuntu Package Dependencies

require 'nokogiri'
require 'open-uri'

class GetPkgDependencies
  VERSION      = 'trusty'
  REPOSITORY   = "packages.ubuntu.com/#{VERSION}"

  attr_accessor :dependencies
  attr_accessor :current_bucket

  def get(file)
    @dependencies   = Array.new(1, Array.new)
    @current_bucket = 0

    get_target_packages(file)
    get_dependencies

    50.times do |i|
      @current_bucket += 1
      get_dependencies(@dependencies[@current_bucket-1])
      @dependencies[@current_bucket].compact!
    end

    write_dependencies
  end

  private

  def get_target_packages(file)
    raise "File does not exist: '#{file}'" unless File.exist?(file)
    @target_packages = File.open(file).readlines
  end

  def get_dependencies(packages=@target_packages)
    @dependencies << Array.new(1)
    packages.each do |pkg|
      url = "http://#{REPOSITORY}/#{pkg}"
      doc = Nokogiri::HTML(open(url))
      nodes = doc.search("ul.uldep li a")
      collect_dependencies(nodes)
    end
  end

  def collect_dependencies(nodes)
    nodes.each do |dependency|
      remove_earlier_references(dependency.text)
      @dependencies[@current_bucket] << dependency.text
    end
  end

  def remove_earlier_references(dependency)
    @dependencies.each do |bucket|
      bucket.delete(dependency)
    end
  end

  def flatten_dependencies
    @dependencies[@current_bucket].uniq!
  end

  def read_dependencies
    @dependencies.each do |bucket|
      puts bucket.inspect
      puts ""
      puts ""
    end
  end

  def write_dependencies
    @dependencies.each_with_index do |bucket, index|
      File.open("dependency_bucket#{index}", 'w+') do |file|
        bucket.each do |pkg|
          file.write("#{pkg}\n")
        end
      end
    end
  end
end

## USAGE
cmd = GetPkgDependencies.new
cmd.get('target_packages')
