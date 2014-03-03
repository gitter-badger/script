# hash_canvas.rb
# Author: Andy Bettisworth
# Description: Canvas TrueClass and FalseClass

# # Hash < Object
# ------------------------------------------------------------------------------
# # Includes:
# Enumerable (from ruby core)

# HashRecursiveMerge (from gem geocoder-1.1.9)

# Mocha::HashMethods (from gem mocha-1.0.0)

# (from gem tins-0.13.1)
#   HashSymbolizeKeysRecursive
#   HashUnion
#   Tins::Subhash

# (from ruby core)
# ------------------------------------------------------------------------------
# A Hash is a dictionary-like collection of unique keys and their values. Also
# called associative arrays, they are similar to Arrays, but where an Array uses
# integers as its index, a Hash allows you to use any object type.

# Hashes enumerate their values in the order that the corresponding keys were
# inserted.

# A Hash can be easily created by using its implicit form:

#   grades = { "Jane Doe" => 10, "Jim Doe" => 6 }

# Hashes allow an alternate syntax form when your keys are always symbols.
# Instead of

#   options = { :font_size => 10, :font_family => "Arial" }

# You could write it as:

#   options = { font_size: 10, font_family: "Arial" }

# Each named key is a symbol you can access in hash:

#   options[:font_size]  # => 10

# A Hash can also be created through its ::new method:

#   grades = Hash.new
#   grades["Dorothy Doe"] = 9

# Hashes have a _d_e_f_a_u_l_t_ _v_a_l_u_e that is returned when
# accessing keys that do not exist in the hash. If no default is set nil is
# used. You can set the default value by sending it as an argument to Hash.new:

#   grades = Hash.new(0)

# Or by using the #default= method:

#   grades = {"Timmy Doe" => 8}
#   grades.default = 0

# Accessing a value in a Hash requires using its key:

#   puts grades["Jane Doe"] # => 0

# # Common Usage
# Hashes are an easy way to represent data structures, such as

#   books         = {}
#   books[:matz]  = "The Ruby Language"
#   books[:black] = "The Well-Grounded Rubyist"

# Hashes are also commonly used as a way to have named parameters in functions.
# Note that no brackets are used below. If a hash is the last argument on a
# method call, no braces are needed, thus creating a really clean interface:

#   Person.create(name: "John Doe", age: 27)

#   def self.create(params)
#     @name = params[:name]
#     @age  = params[:age]
#   end

# # Hash Keys

# Two objects refer to the same hash key when their hash value is identical and
# the two objects are eql? to each other.

# A user-defined class may be used as a hash key if the hash and eql? methods
# are overridden to provide meaningful behavior.  By default, separate instances
# refer to separate hash keys.

# A typical implementation of hash is based on the object's data while eql? is
# usually aliased to the overridden == method:

#   class Book
#     attr_reader :author, :title

#     def initialize(author, title)
#       @author = author
#       @title = title
#     end

#     def ==(other)
#       self.class === other and
#         other.author == @author and
#         other.title == @title
#     end

#     alias eql? ==

#     def hash
#       @author.hash ^ @title.hash # XOR
#     end
#   end

#   book1 = Book.new 'matz', 'Ruby in a Nutshell'
#   book2 = Book.new 'matz', 'Ruby in a Nutshell'

#   reviews = {}

#   reviews[book1] = 'Great reference!'
#   reviews[book2] = 'Nice and compact!'

#   reviews.length #=> 1

# See also Object#hash and Object#eql?
# ------------------------------------------------------------------------------
# # Class Methods
#   []
#   new
#   try_convert

# # Instance Methods
#   ==
#   []
#   []=
#   assoc
#   clear
#   compare_by_identity
#   compare_by_identity?
#   default
#   default=
#   default_proc
#   default_proc=
#   delete
#   delete_if
#   each
#   each_key
#   each_pair
#   each_value
#   empty?
#   eql?
#   fetch
#   flatten
#   has_key?
#   has_value?
#   hash
#   include?
#   inspect
#   invert
#   keep_if
#   key
#   key?
#   keys
#   length
#   member?
#   merge
#   merge!
#   rassoc
#   rehash
#   reject
#   reject!
#   replace
#   select
#   select!
#   shift
#   size
#   store
#   to_a
#   to_h
#   to_hash
#   to_s
#   update
#   value?
#   values
#   values_at

# (from gem activesupport-4.0.2)
# ------------------------------------------------------------------------------
# # Instance Method
#   assert_valid_keys
#   deep_dup
#   deep_merge
#   deep_merge!
#   deep_stringify_keys
#   deep_stringify_keys!
#   deep_symbolize_keys
#   deep_symbolize_keys!
#   deep_transform_keys
#   deep_transform_keys!
#   diff
#   except
#   except!
#   extract!
#   extractable_options?
#   from_trusted_xml
#   from_xml
#   nested_under_indifferent_access
#   reverse_merge
#   reverse_merge!
#   reverse_update
#   slice
#   slice!
#   stringify_keys
#   stringify_keys!
#   symbolize_keys
#   symbolize_keys!
#   to_options
#   to_options!
#   to_param
#   to_query
#   to_xml
#   transform_keys
#   transform_keys!
#   with_indifferent_access

# (from gem i18n-0.6.9)
# ------------------------------------------------------------------------------
# # Constants:
# MERGER:
#   deep_merge_hash! by Stefan Rusterholz, see
#   http://www.ruby-forum.com/topic/142809

# # Instance Methods
#   deep_merge!
#   deep_symbolize_keys
#   except
#   slice

# (from gem sidekiq-2.17.2)
# ------------------------------------------------------------------------------
#   deep_merge
#   deep_merge!
#   stringify_keys
#   symbolize_keys

# (from gem sshkit-1.3.0)
# ------------------------------------------------------------------------------
#   symbolize_keys
#   symbolize_keys!

# (from gem tins-0.13.1)
# ------------------------------------------------------------------------------
#   subhash!

# ------------------------------------------------------------------------------
# Also found in:
#   gem geocoder-1.1.9
#   gem mocha-1.0.0
