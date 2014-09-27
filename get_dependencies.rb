#!/usr/bin/env ruby -w
# get_dependencies.rb
# Author: Andy Bettisworth
# Description: get package dependencies

class DependencyGetter
  def get(packages)
    raise "MissingArgumentError: Target package is required." unless packages[0]

    clear_buckets

    packages.each do |pkg|
      raise "UnknownPackageError: No matching Ubuntu package found named '#{pkg}'" if find_package(pkg) == 0
      download_package(pkg)
      try_install(pkg)
    end
  end

  private

  def clear_buckets
    system('rm -rf *bucket_*')
  end

  def find_package(pkg)
    result = `aptitude show #{pkg}`
    return result.length
  end

  def download_package(pkg)
    system("aptitude download #{pkg}")
  end

  def try_install(pkg)
    system("sudo aptitude install #{pkg}")
  end

  def read_dependencies
  end

  def get_dependencies
  end
end

if ARGV
  getter = DependencyGetter.new
  getter.get(ARGV)
end
