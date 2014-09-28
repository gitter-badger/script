#!/usr/bin/env ruby -w
# get_package.rb
# Author: Andy Bettisworth
# Description: get package and it's dependencies

require 'fileutils'
require 'open-uri'

class PackageDownloader
  attr_accessor :top_directory
  attr_accessor :package_queue
  attr_accessor :dependency_queue

  attr_accessor :target_package_index
  attr_accessor :dependency_index

  def get(packages)
    raise "NoNetworkConnection: Check your network configuration" unless internet_connection?
    raise "MissingArgument: At least one target package is required." unless packages[0]

    @top_directory  = Dir.pwd
    @package_queue = Hash[packages.flatten.each_with_index.map { |value, index| [value, false] }]

    @package_queue.each do |pkg, status|
      raise "UnknownPackageError: '#{pkg}'" unless package_exist?(pkg) || package_local?(pkg)

      until @package_queue[pkg] == true
        Dir.chdir(@top_directory)
        download_package(pkg) unless package_local?(pkg)
        install_target(pkg)
        # install_dependencies(pkg)
      end
    end
  end

  private

  def download_package(pkg)
    system("aptitude download #{pkg}")
  end

  def install_target(pkg)
    result = system("sudo dpkg -i #{pkg}_*")
    @package_queue[pkg] = true if result
  end

  # def install_dependencies(pkg)
  #   system("mkdir -p dependency_bucket_#{@dir_level}")
  #   Dir.chdir("dependency_bucket_#{@dir_level}")

  #   dependencies = read_dependencies
  #   @dir_level += 1

  #   dependencies.each do |dep_pkg|
  #     @target_pakage = dep_pkg
  #     download_package(dep_pkg)

  #     is_installed = false

  #     until is_installed == true
  #       is_installed = install_target(dep_pkg)

  #       Dir.chdir("#{ENV['HOME']}/Desktop")
  #       get_dependencies(dep_pkg)
  #     end
  #   end
  # end

  # def read_dependencies
  #   error = File.open("#{ENV['HOME']}/Desktop/dependency_error#{@dir_level}_#{@target_pakage}").read
  #   error.scan(/depends on (.*)?;/).flatten
  # end

  def package_exist?(pkg)
    result = `aptitude show #{pkg}`
    result.length == 0 ? false : true
  end

  def package_local?(pkg)
    result = Dir["#{pkg}_*"].select { |f| f =~ /#{pkg}_/ }
    result.count == 0 ? false : true
  end

  def internet_connection?
    begin
      true if open("http://www.google.com/")
    rescue
      false
    end
  end
end

if ARGV
  getter = PackageDownloader.new
  getter.get(ARGV)
end
