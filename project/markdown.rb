#!/usr/bin/env ruby
# markdown.rb
# Author: Andy Bettisworth
# Created At: 2015 0513 222040
# Modified At: 2015 0513 222040
# Description: Render GitHub flavored markdown (ie README.md)

require 'github/markup'

if __FILE__ == $0
  if ARGV.size > 0
    ARGV.each do |file_path|
      if File.exist?(file_path)
        filename       = File.basename(file_path)
        filename_noext = File.basename(file_path, File.extname(file_path))
        markdown       = GitHub::Markup.render(filename, File.read(file_path))
        File.open(filename_noext + '.html', 'w+') << markdown
      end
    end
  else
    STDOUT.puts "Usage: markdown FILE..."
    exit 1
  end
end
