#!/usr/bin/ruby -w
# create_file_task.rb
# Author: Andy Bettisworth
# Description: Create a file on Desktop

suffix = Random.new.rand(1..99)
File.open("#{ENV['HOME']}/Desktop/file_#{suffix}.txt",'w')
