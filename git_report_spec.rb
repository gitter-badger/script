#!/usr/bin/env ruby -w
# git_report_spec.rb
# Description: Report commit tree to file

# > play gem install githug
# > canvas git
require 'git'

class GitReport
end

## USAGE
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

describe GitReport do
  describe "#report" do
    context "with the default; last 5 commit history" do
      it "should log the last 5 git commits"
    end

    context "with custom commit history count" do
      it "should log the last 'x' git commits"
    end

    it "should validate project is under git version control"
  end
end
