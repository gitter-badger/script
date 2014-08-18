#!/usr/bin/ruby -w
# mad_libs.rb
# Author: Andy Bettisworth
# Description: Allow creation of a mad lib from the command line

module MadLibGame
  class MadLib < ActiveRecord::Migration
    def change
      create_table :mad_libs do |t|
        t.string :story
      end

      create_table :mad_lib_keywords do |t|
        t.integer :mad_lib_id
        t.string :keyword
      end
    end
  end

  class MadLib < ActiveRecord::Base
    def add_
      puts "The format is to place all the [keywords] or [phrases in brackets like this]."
      raw_mad_lib = gets
      keywords = raw_mad_lib.scan(/\[.*?\]/)
      mad_lib = {}
      keywords.each do |keyword|
        mad_lib[keyword.to_sym] = raw_mad_lib.index(keyword)
      end
      mad_lib
      # > create MadLib.create(story: '', keywords: {})
    end
  end
end

mad_libber = MadLib.new
mad_libber.create

# describe MadLib do
#   describe "#create" do
#     it "should "
#   end
# end
