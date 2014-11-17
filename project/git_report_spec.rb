#!/usr/bin/env ruby -w
# git_report_spec.rb
# Author: Andy Bettisworth
# Description: Report commit tree to file

require 'git'

class GitReport
end

if __FILE__ == $0
  # git_report .
    #=> +   aoeueu au a eueu
    #=> |\
    #=> | * oueoeu
    #=> | |
    #=> | * ae aeu aua uaoeu
    #=> |/
    #=> *   Init
  # git_report -c 2 my_project/
    #=>
    #=> +   aoeueu au a eueu
    #=> |\
    #=> | * oueoeu
end
