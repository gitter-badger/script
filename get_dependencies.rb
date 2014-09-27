#!/usr/bin/env ruby -w
# get_dependencies.rb
# Author: Andy Bettisworth
# Description: get package dependencies

class DependencyGetter
  def get(packages)
    raise "MissingArgumentError: Target package is required." unless packages[0]

    clear_bucket_dependencies

    packages.each do |pkg|
      if package_exist?(pkg)
        download_package(pkg)
        try_install(pkg)
      else
        system("aptitude search #{pkg}")
        raise "UnknownPackageError: No matching Ubuntu package found named '#{pkg}'"
      end
    end
  end

  private

  def clear_bucket_dependencies
    system('rm -rf *bucket_*')
  end

  def package_exist?(pkg)
    result = `aptitude show #{pkg}`
    return result.length == 0 ? false : true
  end

  def download_package(pkg)
    system("aptitude download #{pkg}")
  end

  def try_install(pkg)
    result = false
    count = 0

    until result
      result = system("sudo dpkg -i #{pkg}* 2> dependency_error")

      if result
        puts "SUCCESS! Package '#{pkg}' was installed successfully."
      else
        get_dependencies(read_dependencies, count)
      end

      system('rm dependency_error')
      count += 1
    end
  end

  def read_dependencies
    error = File.open('dependency_error').read
    dependencies = error.scan(/depends on (.*)?;/)
    return dependencies.flatten
  end

  def get_dependencies(dependencies, count)
    system("mkdir dependency_bucket_#{count}")
    Dir.chdir("dependency_bucket_#{count}")

    dependencies.each do |pkg|
      download_package(pkg)
      try_install(pkg)
    end

    Dir.chdir('../')
  end
end

if ARGV
  getter = DependencyGetter.new
  getter.get(ARGV)
end
