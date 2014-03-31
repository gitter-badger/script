#!/usr/bin/ruby -w
# mean_median_mode.rb
# Author: Andy Bettisworth
# Description: Return mean, median, or mode of a collection

class Array
  def mean
    self.each { |x| raise "NonNumericException" unless x.kind_of?(Numeric) }
    self.reduce(:+) / self.size
  end

  def median
    self.each { |x| raise "NonNumericException" unless x.kind_of?(Numeric) }
    self.sort.at(self.size / 2)
  end

  def mode
    self.each { |x| raise "NonNumericException" unless x.kind_of?(Numeric) }
    self.max_by { |x| self.count(x) }
  end
end

describe Array do
  describe "#mean" do
    it "should return 2 if given [1, 2, 3]" do
      expect([1, 2, 3].mean).to equal(2)
    end
  end

  describe "#median" do
    it "should return 3 if given [1, 2, 2, 3, 5, 6, 6]" do
      expect([1, 2, 2, 3, 4, 5, 6].median).to equal(3)
    end
  end

  describe "#mode" do
    it "should return 2 if given [1, 2, 2, 2, 3, 5, 6, 6]" do
      expect([1, 2, 2, 2, 3, 5, 6, 6].mode).to equal(2)
    end
  end

  it "should check that all elements are numeric" do
    lambda {['blah', 1, 2 , 3].mean}.should raise_error
  end

  it "should check that all elements are numeric" do
    lambda {['blah', 1, 2 , 3].median}.should raise_error
  end

  it "should check that all elements are numeric" do
    lambda {['blah', 1, 2 , 3].mode}.should raise_error
  end
end
