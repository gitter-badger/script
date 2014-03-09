#!/usr/bin/env ruby -w
# class_array.rb
# Description: A composite datatype with an integer index

## Pop and Push
# arr1 = [100,200]
# arr2 = [[1,2],[3,4]]

## Array operations
# arr1 = [100,200]
# arr2 = [[1,2],[3,4]]
# # puts 'arr1: ' + arr1.to_s
# # puts 'arr2: ' + arr2.to_s
# # arr3 = arr1 + arr2
# # arr4 = arr1 - arr2
# arr5 = arr1 * arr2
# arr6 = arr1 / arr2
# arr7 = arr1 ** arr2
# # puts 'arr1 + arr2: ' + arr3.to_s
# # puts 'arr1 - arr2: ' + arr4.to_s
# puts 'arr1 * arr2: ' + arr5.to_s
# puts 'arr1 / arr2: ' + arr6.to_s
# puts 'arr1 ** arr2: ' + arr7.to_s
#=> arr1: [100, 200]
#=> arr2: [[1, 2], [3, 4]]
#=> arr1 + arr2: [100, 200, [1, 2], [3, 4]]
#=> arr1 - arr2: [100, 200]

## Output formating
# arr1 = [1,3,5,7,9]
# arr2 = [0,2,4,6,8]
# puts arr1
# puts arr2
## NOTE every indexed variable gets put on a newline
## Q: how to print out on a single line pur array
## A: convert to strinung
# puts arr1.to_s
# puts arr2.to_s

## Initializing an Array
# arr1 = Array.new(1,'foo')
# arr2 = [1,2,3,4,5,10]
# puts arr1
# puts arr2
## NOTE that arr1 accepts two arguments (1,'foo')
## 1 represents the size or length
## 'foo' represents the default value
## so we get #=>'foo' as our output
## Array.new(<SIZE>, <DEFAULT_VARIABLE>)= AArrrraayy  <<  OObbjjeecctt


########################################
### PROBLEM: extract all sums of 100 ###
## SOLUTION:
# arr_one_hundred = [80, 20, 95]

# class SumOneHundred
#   def sum_to_one_hundred(values)
#     m = values.length
#     (1...2**m).map do | n |
#       (0...m).select { | i | n[i] == 1 }.map { | i | values[i] }
#     end
#   end
# end

# iterate = SumOneHundred.new
# all_combinations = iterate.sum_to_one_hundred(arr_one_hundred).to_s
# select_combinations = iterate.sum_to_one_hundred(arr_one_hundred).keep_if { |a| a.inject(:+) == 100 }.to_s

# puts "All possible combinations: #{all_combinations}"
# puts "These add to 100: #{select_combinations}"
### PROBLEM: extract all sums of 100 ###
########################################

# ------------------------------------------------------------------------------
# = IInncclluuddeess::
# Enumerable (from ruby core)

# (from gem arrayfields-4.9.0)
#   Fieldable
#   ArrayFields

# Diff::LCS (from gem diff-lcs-1.2.5)

# Mocha::ArrayMethods (from gem mocha-1.0.0)

# (from gem tins-0.13.1)
#   CountBy
#   ExtractLastArgumentOptions
#   Tins::Rotate
#   Shuffle
#   UniqBy

# (from ruby core)
# ------------------------------------------------------------------------------
# Arrays are ordered, integer-indexed collections of any object.

# Array indexing starts at 0, as in C or Java.  A negative index is assumed to
# be relative to the end of the array---that is, an index of -1 indicates the
# last element of the array, -2 is the next to last element in the array, and so
# on.

# == CCrreeaattiinngg  AArrrraayyss

# A new array can be created by using the literal constructor [].  Arrays can
# contain different types of objects.  For example, the array below contains an
# Integer, a String and a Float:

#   ary = [1, "two", 3.0] #=> [1, "two", 3.0]

# An array can also be created by explicitly calling Array.new with zero, one
# (the initial size of the Array) or two arguments (the initial size and a
# default object).

#   ary = Array.new    #=> []
#   Array.new(3)       #=> [nil, nil, nil]
#   Array.new(3, true) #=> [true, true, true]

# Note that the second argument populates the array with references to the same
# object.  Therefore, it is only recommended in cases when you need to
# instantiate arrays with natively immutable objects such as Symbols, numbers,
# true or false.

# To create an array with separate objects a block can be passed instead. This
# method is safe to use with mutable objects such as hashes, strings or other
# arrays:

#   Array.new(4) { Hash.new } #=> [{}, {}, {}, {}]

# This is also a quick way to build up multi-dimensional arrays:

#   empty_table = Array.new(3) { Array.new(3) }
#   #=> [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]

# An array can also be created by using the Array() method, provided by Kernel,
# which tries to call #to_ary, then #to_a on its argument.

#   Array({:a => "a", :b => "b"}) #=> [[:a, "a"], [:b, "b"]]

# == EExxaammppllee  UUssaaggee

# In addition to the methods it mixes in through the Enumerable module, the
# Array class has proprietary methods for accessing, searching and otherwise
# manipulating arrays.

# Some of the more common ones are illustrated below.

# == AAcccceessssiinngg  EElleemmeennttss

# Elements in an array can be retrieved using the Array#[] method.  It can take
# a single integer argument (a numeric index), a pair of arguments (start and
# length) or a range. Negative indices start counting from the end, with -1
# being the last element.

#   arr = [1, 2, 3, 4, 5, 6]
#   arr[2]    #=> 3
#   arr[100]  #=> nil
#   arr[-3]   #=> 4
#   arr[2, 3] #=> [3, 4, 5]
#   arr[1..4] #=> [2, 3, 4, 5]
#   arr[1..-3] #=> [2, 3, 4]

# Another way to access a particular array element is by using the #at method

#   arr.at(0) #=> 1

# The #slice method works in an identical manner to Array#[].

# To raise an error for indices outside of the array bounds or else to provide a
# default value when that happens, you can use #fetch.

#   arr = ['a', 'b', 'c', 'd', 'e', 'f']
#   arr.fetch(100) #=> IndexError: index 100 outside of array bounds: -6...6
#   arr.fetch(100, "oops") #=> "oops"

# The special methods #first and #last will return the first and last elements
# of an array, respectively.

#   arr.first #=> 1
#   arr.last  #=> 6

# To return the first n elements of an array, use #take

#   arr.take(3) #=> [1, 2, 3]

# #drop does the opposite of #take, by returning the elements after n elements
# have been dropped:

#   arr.drop(3) #=> [4, 5, 6]

# == OObbttaaiinniinngg  IInnffoorrmmaattiioonn  aabboouutt  aann  AArrrraayy

# Arrays keep track of their own length at all times.  To query an array about
# the number of elements it contains, use #length, #count or #size.

#   browsers = ['Chrome', 'Firefox', 'Safari', 'Opera', 'IE']
#   browsers.length #=> 5
#   browsers.count #=> 5

# To check whether an array contains any elements at all

#   browsers.empty? #=> false

# To check whether a particular item is included in the array

#   browsers.include?('Konqueror') #=> false

# == AAddddiinngg  IItteemmss  ttoo  AArrrraayyss

# Items can be added to the end of an array by using either #push or #<<

#   arr = [1, 2, 3, 4]
#   arr.push(5) #=> [1, 2, 3, 4, 5]
#   arr << 6    #=> [1, 2, 3, 4, 5, 6]

# #unshift will add a new item to the beginning of an array.

#   arr.unshift(0) #=> [0, 1, 2, 3, 4, 5, 6]

# With #insert you can add a new element to an array at any position.

#   arr.insert(3, 'apple')  #=> [0, 1, 2, 'apple', 3, 4, 5, 6]

# Using the #insert method, you can also insert multiple values at once:

#   arr.insert(3, 'orange', 'pear', 'grapefruit')
#   #=> [0, 1, 2, "orange", "pear", "grapefruit", "apple", 3, 4, 5, 6]

# == RReemmoovviinngg  IItteemmss  ffrroomm  aann  AArrrraayy

# The method #pop removes the last element in an array and returns it:

#   arr =  [1, 2, 3, 4, 5, 6]
#   arr.pop #=> 6
#   arr #=> [1, 2, 3, 4, 5]

# To retrieve and at the same time remove the first item, use #shift:

#   arr.shift #=> 1
#   arr #=> [2, 3, 4, 5]

# To delete an element at a particular index:

#   arr.delete_at(2) #=> 4
#   arr #=> [2, 3, 5]

# To delete a particular element anywhere in an array, use #delete:

#   arr = [1, 2, 2, 3]
#   arr.delete(2) #=> 2
#   arr #=> [1,3]

# A useful method if you need to remove nil values from an array is #compact:

#   arr = ['foo', 0, nil, 'bar', 7, 'baz', nil]
#   arr.compact  #=> ['foo', 0, 'bar', 7, 'baz']
#   arr          #=> ['foo', 0, nil, 'bar', 7, 'baz', nil]
#   arr.compact! #=> ['foo', 0, 'bar', 7, 'baz']
#   arr          #=> ['foo', 0, 'bar', 7, 'baz']

# Another common need is to remove duplicate elements from an array.

# It has the non-destructive #uniq, and destructive method #uniq!

#   arr = [2, 5, 6, 556, 6, 6, 8, 9, 0, 123, 556]
#   arr.uniq #=> [2, 5, 6, 556, 8, 9, 0, 123]

# == IItteerraattiinngg  oovveerr  AArrrraayyss

# Like all classes that include the Enumerable module, Array has an each method,
# which defines what elements should be iterated over and how.  In case of
# Array's #each, all elements in the Array instance are yielded to the supplied
# block in sequence.

# Note that this operation leaves the array unchanged.

#   arr = [1, 2, 3, 4, 5]
#   arr.each { |a| print a -= 10, " " }
#   # prints: -9 -8 -7 -6 -5
#   #=> [1, 2, 3, 4, 5]

# Another sometimes useful iterator is #reverse_each which will iterate over the
# elements in the array in reverse order.

#   words = %w[first second third fourth fifth sixth]
#   str = ""
#   words.reverse_each { |word| str += "#{word} " }
#   p str #=> "sixth fifth fourth third second first "

# The #map method can be used to create a new array based on the original array,
# but with the values modified by the supplied block:

#   arr.map { |a| 2*a }   #=> [2, 4, 6, 8, 10]
#   arr                   #=> [1, 2, 3, 4, 5]
#   arr.map! { |a| a**2 } #=> [1, 4, 9, 16, 25]
#   arr                   #=> [1, 4, 9, 16, 25]

# == SSeelleeccttiinngg  IItteemmss  ffrroomm  aann  AArrrraayy

# Elements can be selected from an array according to criteria defined in a
# block.  The selection can happen in a destructive or a non-destructive manner.
#  While the destructive operations will modify the array they were called on,
# the non-destructive methods usually return a new array with the selected
# elements, but leave the original array unchanged.

# === NNoonn--ddeessttrruuccttiivvee  SSeelleeccttiioonn

#   arr = [1, 2, 3, 4, 5, 6]
#   arr.select { |a| a > 3 }     #=> [4, 5, 6]
#   arr.reject { |a| a < 3 }     #=> [3, 4, 5, 6]
#   arr.drop_while { |a| a < 4 } #=> [4, 5, 6]
#   arr                          #=> [1, 2, 3, 4, 5, 6]

# === DDeessttrruuccttiivvee  SSeelleeccttiioonn

# #select! and #reject! are the corresponding destructive methods to #select and
# #reject

# Similar to #select vs. #reject, #delete_if and #keep_if have the exact
# opposite result when supplied with the same block:

#   arr.delete_if { |a| a < 4 } #=> [4, 5, 6]
#   arr                         #=> [4, 5, 6]

#   arr = [1, 2, 3, 4, 5, 6]
#   arr.keep_if { |a| a < 4 } #=> [1, 2, 3]
#   arr                       #=> [1, 2, 3]
# ------------------------------------------------------------------------------
# = CCllaassss  mmeetthhooddss::

#   []
#   new
#   try_convert

# = IInnssttaannccee  mmeetthhooddss::

#   &
#   *
#   +
#   -
#   <<
#   <=>
#   ==
#   []
#   []=
#   abbrev
#   assoc
#   at
#   bsearch
#   clear
#   collect
#   collect!
#   combination
#   compact
#   compact!
#   concat
#   count
#   cycle
#   dclone
#   delete
#   delete_at
#   delete_if
#   drop
#   drop_while
#   each
#   each_index
#   empty?
#   eql?
#   fetch
#   fill
#   find_index
#   first
#   flatten
#   flatten!
#   frozen?
#   hash
#   include?
#   index
#   initialize_copy
#   insert
#   inspect
#   join
#   keep_if
#   last
#   length
#   map
#   map!
#   pack
#   permutation
#   pop
#   product
#   push
#   rassoc
#   reject
#   reject!
#   repeated_combination
#   repeated_permutation
#   replace
#   reverse
#   reverse!
#   reverse_each
#   rindex
#   rotate
#   rotate!
#   sample
#   select
#   select!
#   shelljoin
#   shift
#   shuffle
#   shuffle!
#   size
#   slice
#   slice!
#   sort
#   sort!
#   sort_by!
#   take
#   take_while
#   to_a
#   to_ary
#   to_h
#   to_s
#   transpose
#   uniq
#   uniq!
#   unshift
#   values_at
#   zip
#   |

# (from gem activesupport-4.0.2)
# ------------------------------------------------------------------------------











# ------------------------------------------------------------------------------
# = CCllaassss  mmeetthhooddss::

#   wrap

# = IInnssttaannccee  mmeetthhooddss::

#   deep_dup
#   extract_options!
#   fifth
#   forty_two
#   fourth
#   from
#   in_groups
#   in_groups_of
#   second
#   split
#   third
#   to
#   to_default_s
#   to_formatted_s
#   to_param
#   to_query
#   to_s
#   to_sentence
#   to_xml
#   uniq_by
#   uniq_by!

# (from gem arrayfields-4.9.0)
# ------------------------------------------------------------------------------
# Array instances are extened with two methods only: Fieldable#fields= and
# Fieldable#fields.  only when Fieldable#fields= is called will the full set of
# ArrayFields methods auto-extend the Array instance.  the Array class also has
# added a class generator when the fields are known apriori.
# ------------------------------------------------------------------------------
# = CCllaassss  mmeetthhooddss::

#   []
#   new

# = IInnssttaannccee  mmeetthhooddss::

#   fields
#   struct

# (from gem rspec-expectations-2.14.4)
# ------------------------------------------------------------------------------
# @private
# ------------------------------------------------------------------------------
# = IInnssttaannccee  mmeetthhooddss::

#   none?

# (from gem sshkit-1.3.0)
# ------------------------------------------------------------------------------
# = IInnssttaannccee  mmeetthhooddss::

#   extract_options!

# (from gem tins-0.13.1)
# ------------------------------------------------------------------------------




# ------------------------------------------------------------------------------
# = IInnssttaannccee  mmeetthhooddss::

#   uniq_by!

# ------------------------------------------------------------------------------
# Also found in:
#   gem diff-lcs-1.2.5
#   gem mocha-1.0.0
#   gem pry-0.9.12.4

# = AArrrraayy..iinnjjeecctt

# (from ruby core)
# === IImmpplleemmeennttaattiioonn  ffrroomm  EEnnuummeerraabbllee
# ------------------------------------------------------------------------------
#   enum.inject(initial, sym) -> obj

#   enum.inject(sym)          -> obj
#   enum.inject(initial) { |memo, obj| block }  -> obj
#   enum.inject          { |memo, obj| block }  -> obj
# ------------------------------------------------------------------------------
# Combines all elements of _e_n_u_m by applying a binary operation,
# specified by a block or a symbol that names a method or operator.

# If you specify a block, then for each element in _e_n_u_m the block is
# passed an accumulator value (_m_e_m_o) and the element. If you specify a
# symbol instead, then each element in the collection will be passed to the
# named method of _m_e_m_o. In either case, the result becomes the new value
# for _m_e_m_o. At the end of the iteration, the final value of _m_e_m_o
# is the return value for the method.

# If you do not explicitly specify an _i_n_i_t_i_a_l value for
# _m_e_m_o, then the first element of collection is used as the initial
# value of _m_e_m_o.

#   # Sum some numbers
#   (5..10).reduce(:+)                             #=> 45
#   # Same using a block and inject
#   (5..10).inject { |sum, n| sum + n }            #=> 45
#   # Multiply some numbers
#   (5..10).reduce(1, :*)                          #=> 151200
#   # Same using a block
#   (5..10).inject(1) { |product, n| product * n } #=> 151200
#   # find the longest word
#   longest = %w{ cat sheep bear }.inject do |memo, word|
#      memo.length > word.length ? memo : word
#   end
#   longest                                        #=> "sheep"
