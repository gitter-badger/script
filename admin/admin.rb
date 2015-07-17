#!/usr/bin/env ruby
# admin.rb
# Author: Andy Bettisworth
# Created At: 2015 0528 044634
# Modified At: 2015 0528 044634
# Description: system administration module

module Admin
  HOME     = ENV['HOME']
  DESKTOP  = "#{HOME}/Desktop"
  BINARIES = {
    '.c'   => 'gcc',
    '.rb'  => 'ruby',
    '.py'  => 'python',
    '.exp' => 'expect',
    '.js'  => 'node',
    '.sh'  => 'bash'
  }
  DEPENDENCIES = {
    '.c'  => Regexp.new(/include.*?\s\'(?<dependency>.*)\'/i),
    '.rb' => Regexp.new(/require.*?\s\'(?<dependency>.*)\'/i),
    '.py' => Regexp.new(/import.*?\s(?<dependency>.*)/i)
  }
  COMMENTS = {
    '.c'   => '//',
    '.rb'  => '#',
    '.py'  => '#',
    '.exp' => '#',
    '.js'  => '//',
    '.sh'  => '#'
  }

  def require_file(file_path)
    unless File.exist?(file_path)
      raise LoadError, "No such file at '#{file_path}'"
    end
  end
end
