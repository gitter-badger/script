# string_canvas.rb
# Author: Andy Bettisworth
# Description: Canvas String class

# # String < Object
# ------------------------------------------------------------------------------
# # Include:
# Comparable (from ruby core)

# Diff::LCS (from gem diff-lcs-1.2.5)

# Mocha::StringMethods (from gem mocha-1.0.0)

# (from gem tins-0.13.1)
#   StringByteOrderMark
#   StringCamelize
#   StringUnderscore
#   StringVersion

# (from ruby core)
# ------------------------------------------------------------------------------
# BigDecimal extends the native String class to provide the #to_d method.

# When you require BigDecimal in your application, this method will be available
# on String objects.

# Rake extension methods for String.

# A String object holds and manipulates an arbitrary sequence of bytes,
# typically representing characters. String objects may be created using
# String::new or as literals.

# Because of aliasing issues, users of strings should be aware of the methods
# that modify the contents of a String object.  Typically, methods with names
# ending in ``!'' modify their receiver, while those without a ``!'' return a
# new String.  However, there are exceptions, such as String#[]=.
# ------------------------------------------------------------------------------
# # Class Methods
#   new
#   try_convert
# # Instance Methods
## Replace characters inside string
# my_string = 'Testing 1_2_3'
# puts 'updated: ' + my_string.gsub('_',', ')
# puts 'original: ' + my_string
# my_string.gsub!('_',', ')
# puts 'new: ' + my_string

## trim whitespaces
# puts  %{ Multi-line
#           string }.squish
#=> undefined method `squish'
# " foo   bar    \n   \t   boo".squish
#=> undefined method `squish'
# puts String.new('I   \n eat  tacocats.').squish
#=> undefined method `squish'
## SOLVED - requires ActiveSupport gem
# require 'active_support/core_ext/string/filters'
# puts  %{ Multi-line
#           string }.squish
#=> Multi-line string
# puts " foo   bar    \n   \t   boo".squish # => "foo bar boo"
#=> foo bar boo
# puts String.new("I   \n eat  tacocats.").squish
#=> I eat tacocats.

## Format string
# "%d %s" % [1, "message"]
# puts "%d %s" % [1, "taco", "cat"]
#=> 1 taco
# puts "%d %s%s" % [1, "taco", "cat"]
#=> 1 tacocat
# puts "%d%d %s%s" % [1, "taco", "cat"]
#=> canvas_string.rb:10:in `%': invalid value for Integer(): "taco" (ArgumentError)

## String < Object
# ------------------------------------------------------------------------------
## Class Methods
#   new
#   try_convert

## Instance Methods
#   %
#   *
#   +
#   <<
#   <=>
#   ==
#   ===
#   =~
#   []
#   []=
#   ascii_only?
#   b
#   block_scanf
#   bytes
#   bytesize
#   byteslice
#   capitalize
#   capitalize!
#   casecmp
#   center
#   chars
#   chomp
#   chomp!
#   chop
#   chop!
#   chr
#   clear
#   codepoints
#   concat
#   count
#   crypt
#   delete
#   delete!
#   downcase
#   downcase!
#   dump
#   each_byte
#   each_char
#   each_codepoint
#   each_line
#   empty?
#   encode
#   encode!
#   encoding
#   end_with?
#   eql?
#   ext
#   force_encoding
#   getbyte
#   gsub
#   gsub!
#   hash
#   hex
#   include?
#   index
#   initialize_copy
#   insert
#   inspect
#   intern
#   iseuc
#   isjis
#   issjis
#   isutf8
#   kconv
#   length
#   lines
#   ljust
#   lstrip
#   lstrip!
#   match
#   next
#   next!
#   oct
#   ord
#   partition
#   pathmap
#   pathmap_explode
#   pathmap_partial
#   pathmap_replace
#   prepend
#   replace
#   reverse
#   reverse!
#   rindex
#   rjust
#   rpartition
#   rstrip
#   rstrip!
#   scan
#   scanf
#   scrub
#   scrub!
#   setbyte
#   shellescape
#   shellsplit
#   size
#   slice
#   slice!
#   split
#   squeeze
#   squeeze!
#   start_with?
#   strip
#   strip!
#   sub
#   sub!
#   succ
#   succ!
#   sum
#   swapcase
#   swapcase!
#   to_c
#   to_d
#   to_f
#   to_i
#   to_r
#   to_s
#   to_str
#   to_sym
#   toeuc
#   tojis
#   tolocale
#   tosjis
#   toutf16
#   toutf32
#   toutf8
#   tr
#   tr!
#   tr_s
#   tr_s!
#   unpack
#   upcase
#   upcase!
#   upto
#   valid_encoding?

# (from gem activesupport-4.0.2)
# ------------------------------------------------------------------------------
# String inflections define new methods on the String class to transform names
# for different purposes. For instance, you can figure out the name of a table
# from the name of a class.

#   'ScaleScore'.tableize # => "scale_scores"
# ------------------------------------------------------------------------------
# # Instance Methods
#   acts_like_string?
#   at
#   blank?
#   camelcase
#   camelize
#   classify
#   constantize
#   dasherize
#   deconstantize
#   demodulize
#   encoding_aware?
#   exclude?
#   first
#   foreign_key
#   from
#   humanize
#   in_time_zone
#   indent
#   indent!
#   inquiry
#   is_utf8?
#   last
#   mb_chars
#   parameterize
#   pluralize
#   safe_constantize
#   singularize
#   squish
#   squish!
#   strip_heredoc
#   tableize
#   titlecase
#   titleize
#   to
#   to_date
#   to_datetime
#   to_time
#   truncate
#   underscore

# (from gem builder-3.1.4)
# ------------------------------------------------------------------------------
#   Permission is granted for use, copying, modification, distribution,
#   and distribution of modified versions of this work as long as the
#   above copyright notice is included.

# ++

# Enhance the String class with a XML escaped character version of to_s.
# ------------------------------------------------------------------------------
# # Instance Methods
#   _blankslate_as_name
#   to_xs

# (from gem highline-1.6.20)
# ------------------------------------------------------------------------------
# Not a perfect translation, but sufficient for our needs.
# ------------------------------------------------------------------------------
# (from gem i18n-0.6.9)
# ------------------------------------------------------------------------------
# Extension for String class. This feature is included in Ruby 1.9 or later but
# not occur TypeError.

# String#% method which accept "named argument". The translator can know the
# meaning of the msgids using "named argument" instead of %s/%d style.
# ------------------------------------------------------------------------------
# # Constants:
# INTERPOLATION_PATTERN:
#   [not documented]

# INTERPOLATION_PATTERN_WITH_ESCAPE:
#   [not documented]


# # Instance Methods
#   %
#   interpolate_without_ruby_19_syntax

# (from gem mail-2.5.4)
# ------------------------------------------------------------------------------
# This is an almost cut and paste from ActiveSupport v3.0.6, copied in here so
# that Mail itself does not depend on ActiveSupport to avoid versioning
# conflicts

# ------------------------------------------------------------------------------
# # Instance Methods
#   at
#   constantize
#   first
#   from
#   is_utf8?
#   last
#   mb_chars
#   to

# (from gem net-ssh-2.7.0)
# ------------------------------------------------------------------------------
# # Instance Methods
#   bytesize
#   getbyte
#   setbyte

# (from gem rake-10.1.1)
# ------------------------------------------------------------------------------
# Rake extension methods for String.
# ------------------------------------------------------------------------------
# # Instance Methods
#   ext
#   pathmap
#   pathmap_explode
#   pathmap_partial
#   pathmap_replace

# (from gem sidekiq-2.17.2)
# ------------------------------------------------------------------------------
# # Instance Methods
#   constantize

# (from gem terminal-table-1.4.5)
# ------------------------------------------------------------------------------
# # Instance Methods
#   align

# (from gem tins-0.13.1)
# ------------------------------------------------------------------------------
# Also found in:
#   gem cucumber-1.3.10
#   gem diff-lcs-1.2.5
#   gem httpclient-2.3.4.1
#   gem mocha-1.0.0
#!/usr/bin/env ruby -w
# class_string.rb
# Description: An arbitrary sequence of bytes, typically characters.

## Equality or inequality, that is the question
# puts str1 = "tacocat"
# puts str2 = "eskimo"
# puts str1 == str1
# puts str1 == str2
# puts str1 != str1
# puts str1 != str2
# puts str1 <= str2
# puts str1 >= str2
# puts str1 <=> str2

## Search String
# str1 = 'The quick brown fox...'
##str2 = str1.grep('quick')
##puts "str1.grep('quick'): " + str2 ## !NoMethodError
# puts str1 =~ /o/    #=> 12
# puts str1 =~ /r/    #=> 11
# puts str1 =~ /T/    #=> 0
# puts str1 =~ /[he]/ #=> 1
# puts str1 =~ /\W/   #=> 3
## NOTE IF <str> =~ <arg> IS regex <arg> THEN return start position of match ELSE return nil

## Operations on String
# str1 = 'Testing 1 2 3'
# str2 = String.new("Using class method .new")
# str3 = str1 + str2
##str4 = str1 - str2    ## !NoMethodError 'undefined method -'
##str5 = str1 * str2    ## !TypeError 'no implicit conversion of String into Integer'
##str6 = str1 / str2    ## !NoMethodError 'undefined method /'
##str7 = str1 ** str2   ## !NoMethodError 'undefined method **'
# str8 = str1 * 3
# puts 'str1 + str2: ' + str3
# puts 'str1 * 3: ' + str8

## Formatting String
# str1 = 'Testing 1 2 3'
##puts 'str1.to_i: ' + str1.to_i   ## !TypeError 'no implicit conversion of Fixnum into String'
# puts 'str1.to_s: ' + str1.to_s   #=> str1.to_s: Testing 1 2 3
##puts 'str1.to_a: ' + str1.to_a   ## "NoMethodError 'undefined method to_a'
##puts 'str1.to_h: ' + str1.to_h   ## "NoMethodError 'undefined method to_h'
# puts "12345".to_i             #=> 12345
# puts "99 red balloons".to_i   #=> 99
# puts "0a".to_i                #=> 0
# puts "0a".to_i(16)            #=> 10
# puts "hello".to_i             #=> 0
# puts "1100101".to_i(2)        #=> 101
# puts "1100101".to_i(8)        #=> 294977
# puts "1100101".to_i(10)       #=> 1100101
# puts "1100101".to_i(16)       #=> 17826049

## Initializing a String
# str1 = 'Testing 1 2 3'
# str2 = String.new("Using class method .new")
# puts 'str1: ' + str1
# puts 'str2: ' + str2
## String.%
# ------------------------------------------------------------------------------
#   str % arg   -> new_str
# ------------------------------------------------------------------------------

# Format---Uses _s_t_r as a format specification, and returns the result of
# applying it to _a_r_g. If the format specification contains more than one
# substitution, then _a_r_g must be an Array or Hash containing the values to
# be substituted. See Kernel::sprintf for details of the format string.

#   "%05d" % 123                              #=> "00123"
#   "%-5s: %08x" % [ "ID", self.object_id ]   #=> "ID   : 200e14d6"
#   "foo = %{foo}" % { :foo => 'bar' }        #=> "foo = bar"

# (from gem i18n-0.6.9)
# ------------------------------------------------------------------------------
#   %(args)
# ------------------------------------------------------------------------------

# % uses self (i.e. the String) as a format specification and returns the result
# of applying it to the given arguments. In other words it interpolates the
# given arguments to the string according to the formats the string defines.

# There are three ways to use it:
# * Using a single argument or Array of arguments.

#   This is the default behaviour of the String class. See Kernel#sprintf for
#   more details about the format string.

#   Example:
#     "%d %s" % [1, "message"]
#     # => "1 message"

# * Using a Hash as an argument and unformatted, named placeholders.
#   When you pass a Hash as an argument and specify placeholders with %{foo} it
#   will interpret the hash values as named arguments.

#   Example:
#     "%{firstname}, %{lastname}" % {:firstname => "Masao", :lastname => "Mutoh"}
#     # => "Masao Mutoh"

# * Using a Hash as an argument and formatted, named placeholders.
#   When you pass a Hash as an argument and specify placeholders with %<foo>d it
#   will interpret the hash values as named arguments and format the value
#   according to the formatting instruction appended to the closing >.

#   Example:
#     "%<integer>d, %<float>.1f" % { :integer => 10, :float => 43.4 }
#     # => "10, 43.3"


## String.squish
# (from gem activesupport-4.0.2)
# ------------------------------------------------------------------------------
#   squish()
# ------------------------------------------------------------------------------

# Returns the string, first removing all whitespace on both ends of the string,
# and then changing remaining consecutive whitespace groups into one space each.

# Note that it handles both ASCII and Unicode whitespace like mongolian vowel
# separator (U+180E).

#   %{ Multi-line
#      string }.squish                   # => "Multi-line string"
#   " foo   bar    \n   \t   boo".squish # => "foo bar boo"

# = SSttrriinngg..ssccaann

# (from ruby core)
# ------------------------------------------------------------------------------
#   str.scan(pattern)                         -> array
#   str.scan(pattern) {|match, ...| block }   -> str

# ------------------------------------------------------------------------------

# Both forms iterate through _s_t_r, matching the pattern (which may be a
# Regexp or a String). For each match, a result is generated and either added to
# the result array or passed to the block. If the pattern contains no groups,
# each individual result consists of the matched string, $&.  If the pattern
# contains groups, each individual result is itself an array containing one
# entry per group.

#   a = "cruel world"
#   a.scan(/\w+/)        #=> ["cruel", "world"]
#   a.scan(/.../)        #=> ["cru", "el ", "wor"]
#   a.scan(/(...)/)      #=> [["cru"], ["el "], ["wor"]]
#   a.scan(/(..)(..)/)   #=> [["cr", "ue"], ["l ", "wo"]]

# And the block form:

#   a.scan(/\w+/) {|w| print "<<#{w}>> " }
#   print "\n"
#   a.scan(/(.)(.)/) {|x,y| print y, x }
#   print "\n"

# _p_r_o_d_u_c_e_s_:

#   <<cruel>> <<world>>
#   rceu lowlr
