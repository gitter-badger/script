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
