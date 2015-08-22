#!/usr/bin/env ruby -w
# get_package.rb
# Author: Andy Bettisworth
# Description: get package and it's dependencies

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

require 'open-uri'

module Admin
  # Get package and dependencies from Ubuntu servers
  class PackageDownloader
    attr_accessor :top_directory
    attr_accessor :package_queue
    attr_accessor :dependency_queue

    def get(packages)
      raise "NoNetworkConnection: Check your network configuration" unless internet_connection?
      raise "MissingArgument: At least one target package is required." unless packages[0]

      @top_directory    = Dir.pwd
      @package_queue    = Hash[packages.flatten.each_with_index.map { |value, index| [value, false] }]
      @dependency_queue = Hash.new

      @package_queue.each do |pkg, status|
        raise "UnknownPackageError: '#{pkg}'" unless package_exist?(pkg) || package_local?(pkg)

        until @package_queue[pkg] == true
          Dir.chdir(@top_directory)
          download_package(pkg) unless package_local?(pkg)
          install_target(@package_queue, pkg)

          puts ""
          puts "Target package has dependencies: #{pkg}"
          puts ""

          system("mkdir -p #{@top_directory}/dependencies")
          Dir.chdir("#{@top_directory}/dependencies")
          read_dependencies(pkg)
          install_dependencies(pkg)
        end

        system("rm #{@top_directory}/dependencies*")
      end
    end

    private

    def download_package(pkg)
      system("aptitude download #{pkg}")
    end

    def install_target(queue, pkg)
      if system("sudo dpkg -i #{pkg}_* 2> #{@top_directory}/dependencies_#{pkg}")
        queue[pkg] = true
      end
    end

    def read_dependencies(pkg)
      puts ""
      puts "Reading dependencies for: #{pkg}"
      puts ""

      error = File.open("#{@top_directory}/dependencies_#{pkg}").read
      dependencies = error.scan(/depends on (.*)?;/).flatten
      dependencies.collect! { |x| x.gsub(/\W\(.*?\)/, '') }
      dependencies.collect! { |x| x.gsub(/.*?\|/, '').strip }
      @dependency_queue[pkg] = Hash[dependencies.each_with_index.map { |value, index| [value, false] }]
    end

    def install_dependencies(pkg)
      puts <<-STR

 Installing dependencies: #{@dependency_queue[pkg]}"

      STR

      @dependency_queue[pkg].each do |dep|
        until @dependency_queue[pkg][dep] == true
          download_package(dep) unless package_local?(dep)
          install_target(@dependency_queue[pkg], dep)

          read_dependencies(dep)
          install_dependencies(dep)
        end
      end
    end

    def package_exist?(pkg)
      result = `aptitude show #{pkg}`
      result.length == 0 ? false : true
    end

    def package_local?(pkg)
      result = Dir["#{pkg}_*"].select { |f| f =~ /#{pkg}_/ }
      result.count == 0 ? false : true
    end

    def internet_connection?
      true if open('http://www.google.com/')
    rescue
      false
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  include Admin

  if ARGV
    getter = PackageDownloader.new
    getter.get(ARGV)
  else
    puts 'ERROR: Arguments required'
  end
end
