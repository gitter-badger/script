#!/usr/bin/env ruby -w
# minify.rb
# Author: Andy Bettisworth
# Description: Reduce the size of target file

raise 'Target file required.' unless ARGV[0]
raise 'No such file exists.' unless File.exist?(ARGV[0])

content = File.open(ARGV[0]).read
content.gsub!(/\s/, '')
content.gsub!(/\n/, '')

extension = File.extname(ARGV[0])
name = File.basename(ARGV[0]).gsub!(extension, '')
f = File.open("#{name}.min#{extension}", 'w')
f.write(content)
f.close