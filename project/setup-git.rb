#!/usr/bin/env ruby
# setup-git.rb
# Author: Andy Bettisworth
# Created At: 2015 0811 115609
# Modified At: 2015 0811 115609
# Description: set git credentials


if __FILE__ == $PROGRAM_NAME
  require 'optparse'

  options = {}
  option_parser = OptionParser.new do |opts|
    opts.banner = 'USAGE: setup-git [options]'

    opts.on('-u', '--username NAME', 'Git username') do |name|
      options[:username] = name
    end

    opts.on('-e', '--email ADDR', 'Git email') do |addr|
      options[:email] = addr
    end
  end
  option_parser.parse!

  if options[:username] && options[:email]
    system('git config --global color.ui true')
    system('git config --global user.name "#{options[:username]}"')
    system('git config --global user.email "#{options[:email]}"')
    ## linux
    # system('git config --global credential.helper "cache --timeout=3600"')
    ## Windows
    system('git config --global credential.helper wincred')
    system('git config --global core.editor "atom -n"')
  else
    puts option_parser
    exit 1
  end
end
