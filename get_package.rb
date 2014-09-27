#!/usr/bin/env ruby -w
# get_package.rb
# Author: Andy Bettisworth
# Description: get package and it's dependencies

require 'fileutils'
require 'open-uri'

class PackageDownloader

  attr_accessor :dependency_count
  attr_accessor :target_pakage

  def get(packages)
    raise "NoNetworkConnection: Check your network configuration" unless internet_connection?
    raise "MissingArgumentError: Target package is required." unless packages[0]

    packages.each do |pkg|
      raise "UnknownPackageError: '#{pkg}'" unless package_exist?(pkg)

      Dir.chdir("#{ENV['HOME']}/Desktop")
      download_package(pkg)

      @target_pakage    = pkg
      @dependency_count = 0
      is_installed      = false

      until is_installed == true
        Dir.chdir("#{ENV['HOME']}/Desktop")
        is_installed = install_target(pkg)

        get_dependencies(pkg)
      end
    end
  end

  private

  def internet_connection?
    begin
      true if open("http://www.google.com/")
    rescue
      false
    end
  end

  def package_exist?(pkg)
    result = `aptitude show #{pkg}`
    result.length == 0 ? false : true
  end

  def download_package(pkg)
    system("aptitude download #{pkg}")
  end

  def install_target(pkg)
    result = system("sudo dpkg -i #{pkg}* 2> #{ENV['HOME']}/Desktop/dependency_error#{@dependency_count}_#{@target_pakage}")
    result ? true : false
  end

  def get_dependencies(pkg)
    # > Q: why are unused directories being created
    system("mkdir -p dependency_bucket_#{@dependency_count}")
    Dir.chdir("dependency_bucket_#{@dependency_count}")

    dependencies = read_dependencies
    @dependency_count += 1

    dependencies.each do |dep_pkg|
      @target_pakage = dep_pkg
      download_package(dep_pkg)

      is_installed = false

      until is_installed == true
        is_installed = install_target(dep_pkg)

        Dir.chdir("#{ENV['HOME']}/Desktop")
        get_dependencies(dep_pkg)
      end
    end
  end

  def read_dependencies
    error = File.open("#{ENV['HOME']}/Desktop/dependency_error#{@dependency_count}_#{@target_pakage}").read
    error.scan(/depends on (.*)?;/).flatten
  end
end

if ARGV
  getter = PackageDownloader.new
  getter.get(ARGV)
end
