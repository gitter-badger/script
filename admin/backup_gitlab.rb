#!/usr/bin/env ruby
# backup_gitlab.rb
# Author: Andy Bettisworth
# Created At: 2015 0101 093459
# Modified At: 2015 0101 093459
# Description: Package current gitlab-server Vagrant box with '-YYYYMMDD.box'


Today.now
File.exist?("#{ENV['HOME']}/.vagrants/gitlab-server")
File.exist?("#{ENV['HOME']}/.vagrant.d/boxes/gitlab-server")

