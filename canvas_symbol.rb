# symbol_canvas.rb
# Author: Andy Bettisworth
# Description: Canvas Symbol class

# # Symbol < Object
# ------------------------------------------------------------------------------
# # Includes:
# Comparable (from ruby core)

# ToProc (from gem tins-0.13.1)

# (from ruby core)
# ------------------------------------------------------------------------------
# Symbol serialization/deserialization

# Symbol objects represent names and some strings inside the Ruby interpreter.
# They are generated using the :name and :"string" literals syntax, and by the
# various to_sym methods. The same Symbol object will be created for a given
# name or string for the duration of a program's execution, regardless of the
# context or meaning of that name. Thus if Fred is a constant in one context, a
# method in another, and a class in a third, the Symbol :Fred will be the same
# object in all three contexts.

#   module One
#     class Fred
#     end
#     $f1 = :Fred
#   end
#   module Two
#     Fred = 1
#     $f2 = :Fred
#   end
#   def Fred()
#   end
#   $f3 = :Fred
#   $f1.object_id   #=> 2514190
#   $f2.object_id   #=> 2514190
#   $f3.object_id   #=> 2514190

# BigDecimal extends the native Integer class to provide the #to_d method.

# When you require the BigDecimal library in your application, this methodwill
# be available on Integer objects.

# Add double dispatch to Integer


# This class is the basis for the two concrete classes that hold whole numbers,
# Bignum and Fixnum.
# ------------------------------------------------------------------------------
# # Class Methods
#   all_symbols
#   each_prime
#   from_prime_division
#   json_create

# # Instance Methods
#   <=>
#   ==
#   ===
#   =~
#   []
#   as_json
#   capitalize
#   casecmp
#   ceil
#   chr
#   dclone
#   denominator
#   downcase
#   downto
#   empty?
#   encoding
#   even?
#   floor
#   gcd
#   gcdlcm
#   id2name
#   inspect
#   integer?
#   intern
#   lcm
#   length
#   match
#   next
#   numerator
#   odd?
#   ord
#   pred
#   prime?
#   prime_division
#   rationalize
#   round
#   size
#   slice
#   succ
#   swapcase
#   times
#   to_bn
#   to_d
#   to_i
#   to_int
#   to_json
#   to_proc
#   to_r
#   to_s
#   to_sym
#   truncate
#   upcase
#   upto

# (from gem activesupport-4.0.2)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# # Instance Methods
#   duplicable?

# (from gem builder-3.1.4)
# ------------------------------------------------------------------------------
#   _blankslate_as_name

# (from gem json-1.8.1)
# ------------------------------------------------------------------------------
# Symbol serialization/deserialization
# ------------------------------------------------------------------------------
#   json_create

#   as_json
#   to_json

# (from gem tins-0.13.1)
# ------------------------------------------------------------------------------
# :nocov:
# ------------------------------------------------------------------------------
