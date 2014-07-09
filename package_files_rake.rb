#!/usr/bin/ruby -w
# package_files_rake.rb
# Author: Andy Bettisworth
# Description:

require 'rake'
require 'rake/packagetask'

include Rake

SM_VERSION = '0.0.1'

PackageTask.new('sm-ruby', SM_VERSION) do |p|
  p.need_tar = true
  p.package_files.include('lib/**/*.rb')
end

namespace :ruby do
  PackageTask.new('sm-ruby', SM_VERSION) do |p|
    p.need_tar = true
    p.need_zip = true
    p.package_files.include('lib/**/*.rb')
  end
end

namespace :java do
  PackageTask.new('am-java', SM_VERSION) do |p|
    p.need_tar = true
    p.need_zip = true
    p.package_files.include('lib/**/*.java')
    p.package_files.include('build.xml')
  end
end
