# range_canvas.rb
# Author: Andy Bettisworth
# Description: Canvas Range class


# # Range < Object
# ------------------------------------------------------------------------------
# # Include
# Enumerable (from ruby core)

# RangePlus (from gem tins-0.13.1)

# (from ruby core)
# ------------------------------------------------------------------------------
# Range serialization/deserialization

# A Range represents an interval---a set of values with a beginning and an end.
# Ranges may be constructed using the _s.._e and _s..._e literals, or with
# Range::new. Ranges constructed using .. run from the beginning to the end
# inclusively. Those created using ... exclude the end value. When used as an
# iterator, ranges return each value in the sequence.

#   (-1..-5).to_a      #=> []
#   (-5..-1).to_a      #=> [-5, -4, -3, -2, -1]
#   ('a'..'e').to_a    #=> ["a", "b", "c", "d", "e"]
#   ('a'...'e').to_a   #=> ["a", "b", "c", "d"]

# # Custom Objects in ranges
# Ranges can be constructed using any objects that can be compared using the <=>
# operator. Methods that treat the range as a sequence (#each and methods
# inherited from Enumerable) expect the begin object to implement a succ method
# to return the next object in sequence. The #step and #include? methods require
# the begin object to implement succ or to be numeric.

# In the Xs class below both <=> and succ are implemented so Xs can be used to
# construct ranges. Note that the Comparable module is included so the == method
# is defined in terms of <=>.

#   class Xs                # represent a string of 'x's
#     include Comparable
#     attr :length
#     def initialize(n)
#       @length = n
#     end
#     def succ
#       Xs.new(@length + 1)
#     end
#     def <=>(other)
#       @length <=> other.length
#     end
#     def to_s
#       sprintf "%2d #{inspect}", @length
#     end
#     def inspect
#       'x' * @length
#     end
#   end

# An example of using Xs to construct a range:

#   r = Xs.new(3)..Xs.new(6)   #=> xxx..xxxxxx
#   r.to_a                     #=> [xxx, xxxx, xxxxx, xxxxxx]
#   r.member?(Xs.new(5))       #=> true
# ------------------------------------------------------------------------------
# # Class Methods
#   json_create
#   new

# # Instance Methods
#   ==
#   ===
#   as_json
#   begin
#   bsearch
#   cover?
#   each
#   end
#   eql?
#   exclude_end?
#   first
#   hash
#   include?
#   inspect
#   last
#   max
#   member?
#   min
#   size
#   step
#   to_json
#   to_s

# (from gem activesupport-4.0.2)
# ------------------------------------------------------------------------------
# # Constants
# RANGE_FORMATS:
#   [not documented]


# # Instance Methods
#   include_with_range?
#   overlaps?
#   to_default_s
#   to_formatted_s
#   to_s

# (from gem json-1.8.1)
# ------------------------------------------------------------------------------
# Range serialization/deserialization
# ------------------------------------------------------------------------------
# # Class Methods
#   json_create

# # Instance Methods
#   as_json
#   to_json

# ------------------------------------------------------------------------------
# Also found in:
#   gem tins-0.13.1
