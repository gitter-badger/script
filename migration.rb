#!/usr/bin/ruby -w
# migration.rb
# Author: Andy Bettisworth
# Description: Migration generator

class Migration

end

describe Migration do
  describe "#generate" do
    it "should be created within a subdirectory named 'migrate'" do

    end

    it "should prefix file name with 'Time.now.strftime(%Y%m%d%H%M%S)'"
    it "should suffix file name with command-line argument"
    it "should use CamelCase to lowercase underscore separated conversion"
    it "should include a subclass of ActiveRecord::Migration"
  end
end
