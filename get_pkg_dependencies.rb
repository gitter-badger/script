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

    # > repeat until all dependencies covered
    # Q: how to exclude pkgs that are already on Ubuntu Default Install (libc6)
    puts @dependencies[@current_bucket]
  end

  private

  def get_target_packages(file)
    raise "File does not exist: '#{file}'" unless File.exist?(file)
    @target_packages = File.open(file).readlines
  end

  def get_dependencies
    @target_packages.each do |pkg|
      url = "http://#{REPOSITORY}/#{pkg}"
      doc = Nokogiri::HTML(open(url))
      nodes = doc.search("ul.uldep li a")
      collect_dependencies(nodes)
    end
    flatten_dependencies
  end

  def collect_dependencies(nodes)
    nodes.each do |dependency|
      @dependencies[@current_bucket] << dependency.text
    end
  end

  def flatten_dependencies
    @dependencies[@current_bucket].uniq!
  end
end

## USAGE
cmd = GetPkgDependencies.new
cmd.get('target_packages')
