#!/usr/bin/env ruby -w
# canvas_descriptive_statistics.rb
# Description: Canvas Gem: descriptive-statistics

require 'descriptive_statistics'

## NOTES
# This gem adds methods to the Enumerable module to allow easy calculation of basic descriptive statistics for a set of data:
# Number - the sample size
# Sum
# Mean
# Median
# Mode
# Variance
# Standard Deviation
# Percentile - A method returning the value corresponding to the supplied percentile. For example, data.percentile(50) should equal data.median.
# Descriptive statistics - A method returning a hash with the above keys (as symbols). Percentile is represented as the first three quartes in the symbols q1, q2 and q3.

# > require 'descriptive_statistics'
#  => true
# > data = [2,6,9,3,5,1,8,3,6,9,2]
#  => [2, 6, 9, 3, 5, 1, 8, 3, 6, 9, 2]
# > data.number
#  => 11.0
# > data.sum
#  => 54
# > data.mean
#  => 4.909090909090909
# > data.median
#  => 5.0
# > data.variance
#  => 7.7190082644628095
# > data.standard_deviation
#  => 2.778310325442932
# > data.percentile(70)
#  => 6.0
# > data.percentile(70)
#  => 6.0
# > data.descriptive_statistics
#  => {:number=>11.0,
#   :sum=>54,
#   :variance=>7.7190082644628095,
#   :standard_deviation=>2.778310325442932,
#   :min=>1,
#   :max=>9,
#   :mean=>4.909090909090909,
#   :mode=>2,
#   :median=>5.0,
#   :range=>8,
#   :q1=>2.5,
#   :q2=>5.0,
#   :q3=>7.0}
# > [4,2,3,1,4,5,6,8,0].mode
#  => 4
# > [17, 5, 3, 23, 33, 30, 45, 37].range
#  => 42

## NOTES for NOT monkey-patching Enumerable
# > require 'descriptive_statistics/safe'
#  => true
# > data = [2,6,9,3,5,1,8,3,6,9,2]
#  => [2, 6, 9, 3, 5, 1, 8, 3, 6, 9, 2]
# > data.extend(DescriptiveStatistics)
#  => [2, 6, 9, 3, 5, 1, 8, 3, 6, 9, 2]
# > data.number
#  => 11.0
# > data.sum
#  => 54
